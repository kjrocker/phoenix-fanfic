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
alias FfReader.Fiction.Category
alias FfReader.Repo

# categories = [
#   %{name: "Anime/Manga"},
#   %{name: "Books"},
#   %{name: "Movies"},
#   %{name: "TV Shows"},
#   %{name: "Comics"},
#   %{name: "Games"},
#   %{name: "Plays/Musicals"},
#   %{name: "Other"}
# ]
#
# for c <- categories do
#   FfReader.Fiction.create_category(c)
# end

Repo.delete_all(FfReader.Fiction.Series)

books = FfReader.Fiction.get_category(2)

series = [
  %{title: "Worm", category: books},
  %{title: "Pact", category: books},
  %{title: "Twig", category: books},
  %{title: "Harry Potter", category: books}
]

for s <- series do
  FfReader.Fiction.create_series(s)
end
