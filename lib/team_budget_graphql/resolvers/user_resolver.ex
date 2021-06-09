defmodule TeamBudgetGraphql.Resolvers.UserResolver do
  alias TeamBudget.Accounts

  def list_users(_parent, params, resolutions) do
    {:ok, Accounts.list_users()}
  end

  def create_user(_parent, %{user: user}, resolutions) do
    Accounts.create_user(user)
  end
end
