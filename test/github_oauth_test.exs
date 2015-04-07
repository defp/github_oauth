defmodule GithubOauthTest do
  use ExUnit.Case

  def config do
    %GithubOauth.Config{
      client_id: "client_id",
      secret: "secret",
      callback_url: "callback_url"
    }
  end

  test "get_authorize_url" do
    url = GithubOauth.get_authorize_url(config)
    assert String.contains?(url, "https://github.com/login/oauth/authorize")
    assert String.contains?(url, "client_id=client_id")
    assert String.contains?(url, "redirect_uri=callback_url")
  end
end
