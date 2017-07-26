defmodule FfReader.Web.ConfirmationController do
  use FfReader.Web, :controller
  alias FfReader.Accounts

  def edit(conn, %{"id" => token}) do
    user = Accounts.find_confirmation(token)

    case user do
      nil ->
        conn
        |> put_flash(:error, "Confirmation Token Invalid")
        |> put_status(:not_found)
        |> render(FfReader.Web.ErrorView, "404.html")
      user ->
        case Accounts.confirm!(user) do
          {:ok, _user} ->
            conn
            |> put_flash(:info, "Email Confirmed Successfully")
            |> redirect(to: "/")
          {:error, _} ->
            conn
            |> put_flash(:error, "Problem Confirming Email Address")
            |> redirect(to: "/")
        end
    end
  end
end
