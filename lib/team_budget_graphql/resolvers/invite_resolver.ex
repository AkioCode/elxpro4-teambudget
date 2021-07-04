defmodule TeamBudgetGraphql.Resolvers.InviteResolver do
  alias TeamBudget.Invites

  def send_invite(_parent, %{invites: invites}, %{
        context: %{current_user: current_user, team: team}
      }) do
    Invites.send_invite(invites, current_user, team)
  end

  def create_user(_parent, %{user: user}, resolutions) do
    Accounts.create_user(user)
  end
end
