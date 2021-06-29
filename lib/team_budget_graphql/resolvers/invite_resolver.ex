defmodule TeamBudgetGraphql.Resolvers.InviteResolver do
  alias TeamBudget.Accounts

  def send_invite(_parent, params, resolutions) do
    IO.inspect(params)
    {:ok, %{}}
  end

  def create_user(_parent, %{user: user}, resolutions) do
    Accounts.create_user(user)
  end
end
