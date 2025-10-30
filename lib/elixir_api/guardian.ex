defmodule ElixirApi.Guardian do
  use Guardian, otp_app: :elixir_api

  alias ElixirApi.Accounts

  # Encode the user into a token
  def subject_for_token(user, _claims), do: {:ok, to_string(user.id)}

  # Decode token back to a user
  def resource_from_claims(%{"sub" => id}), do: {:ok, Accounts.get_user!(id)}
end
