defimpl Canada.Can, for: FfReader.Accounts.User do
  alias FfReader.Accounts.User
  alias FfReader.Fiction.Story

  def can?(%User{ id: user_id }, action, %User{ id: user_id }), do: true

  def can?(%User{ id: user_id }, action, %Story{ author_id: user_id }), do: true

  def can?(%User{ id: user_id }, _, _), do: false
end
