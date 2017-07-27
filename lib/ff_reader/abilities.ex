defimpl Canada.Can, for: FfReader.Accounts.User do
  alias FfReader.Accounts.User
  alias FfReader.Fiction.{Story, Category, Series}

  def can?(%User{ id: user_id }, _, %User{ id: user_id }), do: true

  def can?(%User{ id: user_id }, _, %Story{ author_id: user_id }), do: true

  def can?(%User{ admin: true }, _ , %Category{}), do: true

  def can?(%User{ admin: true }, _, %Series{}), do: true

  def can?(%User{ id: user_id }, _, _), do: false
end
