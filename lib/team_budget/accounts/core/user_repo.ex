defmodule TeamBudget.Accounts.Core.UserRepo do
  import Ecto.Query
  alias TeamBudget.Accounts.Data.User
  alias TeamBudget.Repo

  def list_users() do
    Repo.all(User)
  end

  def create_user(user) do
    user
    |> User.changeset()
    |> Repo.insert()
  end

  def get_by_email(email) when is_binary(email), do: Repo.get_by(User, email: email)

  def get_user!(id) when is_bitstring(id), do: Repo.get!(User, id)
end
