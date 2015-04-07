defmodule GithubOauth do
  defmodule Config do
    defstruct site: "https://api.github.com",
              authorize_url: "https://github.com/login/oauth/authorize",
              token_url: "https://github.com/login/oauth/access_token",
              client_id: nil,
              secret: nil,
              scope: "public_repo",
              callback_url: nil
  end

  defmodule TokenError do
    defexception message: "github access_token error"
  end

  defmodule User do
    defstruct login: nil, 
              id: nil, 
              avatar_url: nil, 
              name: nil, 
              blog: nil, 
              email: nil, 
              access_token: nil
  end

  def get_authorize_url(config) do
    query_params = URI.encode_query(%{
      client_id: config.client_id,
      redirect_uri: config.callback_url,
      scope: config.scope
    })

    config.authorize_url <> "?" <> query_params
  end

  def get_token(config, code) do
    query_params = URI.encode_query(%{
      client_id: config.client_id,
      client_secret: config.secret,
      redirect_uri: config.callback_url,
      code: code,
    })

    headers = [
      {"Content-Type", "application/x-www-form-urlencoded"},
      {"Accept", "application/json"}
    ]

    HTTPoison.post!(config.token_url, query_params, headers).body
    |> Poison.Parser.parse!
    |> parse_token
  end

  defp parse_token(json) do
    if json["error"] do
      raise TokenError
    else
      json["access_token"]
    end
  end

  def raw_info(config, token, struct) do
    headers = [{"Authorization", " token #{token}"}]
    HTTPoison.get!(config.site <> "/user", headers).body
    |> Poison.decode!(as: struct)
    |> Map.put(:access_token, token)
  end

  def raw_info(config, token) do
    raw_info(config, token, User)
  end
end
