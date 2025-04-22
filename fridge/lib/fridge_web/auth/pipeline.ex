defmodule FridgeWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :fridge,
    module: Fridge.Auth.Guardian,
    error_handler: FridgeWeb.Auth.ErrorHandler

  plug Guardian.Plug.VerifyHeader, claims: %{"typ" => "access"}
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource, allow_blank: true
end

defmodule FridgeWeb.Auth.ErrorHandler do
  import Plug.Conn

  @behaviour Guardian.Plug.ErrorHandler

  @impl Guardian.Plug.ErrorHandler
  def auth_error(conn, {type, _reason}, _opts) do
    body = Jason.encode!(%{error: to_string(type)})
    
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(401, body)
  end
end
