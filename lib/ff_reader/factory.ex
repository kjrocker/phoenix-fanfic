defmodule FfReader.Factory do
  use ExMachina.Ecto, repo: FfReader.Repo

  def user_factory do
    %FfReader.Accounts.User{
      email: sequence(:email, &"email-#{&1}@example.com")
    }
  end

  def story_factory do
    %FfReader.Fiction.Story{
      title: "The Generic of Male Lead",
      summary: "A tale of heroism, harems, and other such nonsense",
      author: build(:user)
    }
  end
end
