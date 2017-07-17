defmodule FfReader.Factory do
  use ExMachina.Ecto, repo: FfReader.Repo

  def user_factory do
    %FfReader.Accounts.User{
      email: sequence(:email, &"email-#{&1}@example.com")
    }
  end
end
