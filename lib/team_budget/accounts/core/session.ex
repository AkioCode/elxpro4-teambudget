defmodule TeamBudget.Accounts.Core.Session do
  alias TeamBudget.Accounts.Core.UserRepo
  alias TeamBudget.Accounts.Core.Guardian
  alias TeamBudget.Accounts.Data.User

  def login(%{email: _email, password: _password} = credentials) do
    with {:ok, %User{} = user} <- authenticate(credentials),
         {:ok, token, _claims} = Guardian.sign_in(user) do
      {:ok, %{token: token, user: user}}
    end
  end

  defp authenticate(credentials) do
    credentials.email
    |> UserRepo.get_by_email()
    |> case do
      nil ->
        {:error, "Incorrect login credentials"}

      user ->
        if Argon2.verify_pass(credentials.password, user.password_hash) do
          {:ok, user}
        else
          {:error, :unauthorized}
        end
    end
  end
end
