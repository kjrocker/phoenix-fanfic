defimpl Canada.Can, for: FfReader.Accounts.User do
  alias FfReader.Accounts.User
  def can?(%User{ id: _ }, _, _), do: true
end
