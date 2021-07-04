alias TeamBudget.{Accounts.Data.User, Teams.Data.Team, Members.Data.Member, Repo}

{:ok, %{id: user_id, teams: [%{id: team_id} | _]}} =
  %{
    first_name: "Cafe",
    last_name: "Pilao",
    email: "cafe.pilao@mail.com",
    password: "123456",
    password_confirmation: "123456",
    teams: [
      %{name: "Time 01", description: "Time 01"}
    ]
  }
  |> User.changeset()
  |> Repo.insert()

{:ok, u2} =
  %{
    first_name: "Cafe",
    last_name: "3 Coracoes",
    email: "cafe.3coracoes@mail.com",
    password: "123456",
    password_confirmation: "123456"
  }
  |> User.changeset()
  |> Repo.insert()

%Member{user_id: u2.id, team_id: team_id}
|> Repo.insert()

{:ok, u3} =
  %{
    first_name: "Cafe",
    last_name: "Nescafe",
    email: "necafe@mail.com",
    password: "123456",
    password_confirmation: "123456"
  }
  |> User.changeset()
  |> Repo.insert()
