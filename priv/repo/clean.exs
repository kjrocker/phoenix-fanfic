alias FfReader.Repo

Repo.delete_all(FfReader.Fiction.Chapter)
Repo.delete_all(FfReader.Fiction.Story)
Repo.delete_all(FfReader.Accounts.User)
