defmodule ElixirApiWeb.AuthPipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :elixir_api,
    module: ElixirApi.Guardian,
    error_handler: ElixirApiWeb.AuthErrorHandler

  plug Guardian.Plug.VerifyHeader, scheme: "Bearer"
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
