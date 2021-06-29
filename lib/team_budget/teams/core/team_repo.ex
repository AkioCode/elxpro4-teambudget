defmodule TeamBudget.Teams.Core.TeamRepo do
  import Ecto.Query
  alias TeamBudget.Teams.Data.Team
  alias TeamBudget.Accounts.Data.User
  alias TeamBudget.Repo

  def list_teams() do
    Repo.all(Team)
  end

  def list_teams(user_id) do
    from(
      t in Team,
      join:
        u in assoc(t, :user),
      where:
        t.user_id == ^user_id,
      preload: [:user]
    )
    |> Repo.all()
  end

  def create_user(team) do
    team
    |> Team.changeset()
    |> Repo.insert()
  end

  def get_by_name(name) when is_binary(name), do: Repo.get_by(Team, name: name)

  def get_by_slug(slug), do: Repo.get_by(Team, slug: slug)

  def get_team!(id) when is_bitstring(id), do: Repo.get!(Team, id)
end
