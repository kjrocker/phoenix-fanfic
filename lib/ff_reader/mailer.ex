defmodule FfReader.Mailer do
  use Bamboo.Mailer, otp_app: :ff_reader
end

defmodule FfReader.Email do
  use Bamboo.Phoenix, view: FfReader.Web.EmailView
  alias FfReader.Web.LayoutView

  def confirmation_email(user, url) do
    base_email()
    |> to(user.email)
    |> subject("Fanfic.Co Email Confirmation")
    |> assign(:user, user)
    |> assign(:url, url)
    |> render("confirmation.html")
  end

  defp base_email do
    new_email()
    |> from("Fanfic.Co Robots<no-reply@fanfic.co>")
    |> put_layout({LayoutView, :email})
  end
end
