defmodule FridgeWeb.AuthJSON do
  def login(%{user: user, token: token}) do
    %{
      data: %{
        id: user.id,
        email: user.email,
        token: token
      }
    }
  end
end
