defmodule TeamBudgetGraphql.Resolvers.UserResolver do

  def list_users(_parent, params, resolutions) do
    # {:ok, %{email: "lalala@mail.com"}}
    {:error, "something went wrong"}
  end
end
