# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     FfReader.Repo.insert!(%FfReader.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
import FfReader.Factory
alias FfReader.Accounts
alias FfReader.Repo

Repo.delete_all(FfReader.Accounts.User)

users = [
  %{email: "kevin@example.com", username: "Kehvyn", password: "password"},
  %{email: "testing@example.com", username: "Testing", password: "password"},
  %{email: "author@example.com", username: "Author", password: "password"}
]

for user <- users do
  case Accounts.create_user(user) do
    {:ok, user} ->
      Accounts.confirm!(user)
    {:error, changeset} ->
       IO.inspect(changeset)
  end
end

author = %{email: "seed_author@example.com", username: "Seed Author", password: "password"}
{_, author} = Accounts.create_user(author)
Accounts.confirm!(author)

insert_list(25, :story, author: author)
