defmodule TeamBudget.Members.Core.MembersRepo do
  import Ecto.Query
  alias TeamBudget.Repo
  alias TeamBudget.Members.Data.Member

  def is_member_of?(user_id, team_id) do
    from(
      m in Member,
      where:
        m.user_id == ^user_id and
          m.team_id == ^team_id
    )
    |> Repo.exists?()
  end
end
