defmodule FfReader.Web.Auth.GuardianSerializer do
  @behaviour Guardian.Serializer

  alias FfReader.Accounts

  def for_token(user = %Accounts.User{}), do: { :ok, "User:#{user.id}" }
  def for_token(_), do: { :error, "Unknown resource type" }

  def from_token("User:" <> id) do
    case Accounts.get_user(id) do
      %Accounts.User{} = user ->
        {:ok, user}
      nil ->
        {:error, "Unknown resource type"}
    end
  end

  def from_token(_), do: { :error, "Unknown resource type" }
end
