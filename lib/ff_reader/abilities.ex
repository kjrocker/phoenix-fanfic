defimpl Canada.Can, for: FfReader.Accounts.User do
  alias FfReader.Accounts.User
  
  def can?(%User{ id: user_id }, action, %User{ id: user_id }), do: true
  def can?(%User{ id: user_id }, _, _), do: false
end
