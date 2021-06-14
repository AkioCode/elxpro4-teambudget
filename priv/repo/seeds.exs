# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     TeamBudget.Repo.insert!(%TeamBudget.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias TeamBudget.{Accounts.User, Repo}

%{
  first_name: "Cafe",
  last_name: "Pilao",
  email: "cafe.pilao@mail.com",
  password: "123456",
  password_confirmation: "123456"
}
|> User.changeset()
|> Repo.insert()

%{
  first_name: "Cafe",
  last_name: "3 Coracoes",
  email: "cafe.3coracoes@mail.com",
  password: "123456",
  password_confirmation: "123456"
}
|> User.changeset()
|> Repo.insert()
