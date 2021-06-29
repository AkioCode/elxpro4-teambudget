defmodule TeamBudgetGraphql.Schema do
  use Absinthe.Schema
  alias TeamBudgetGraphql.Resolvers
  alias TeamBudgetGraphql.Middleware

  import_types(TeamBudgetGraphql.Types)

  import AbsintheErrorPayload.Payload
  import_types(AbsintheErrorPayload.ValidationMessageTypes)

  payload_object(:user_payload, :user)
  payload_object(:login_payload, :session)

  query do
    @desc "Get list of all users"
    field :list_users, list_of(:user) do
      middleware(Middleware.Authorize, :user)
      resolve(&Resolvers.UserResolver.list_users/3)
    end

    @desc "Get list of all teams from a User"
    field :list_teams, list_of(:team) do
      middleware(Middleware.Authorize, :user)
      resolve(&Resolvers.TeamResolver.list_teams/3)
    end
  end

  mutation do
    @desc "Create a new user"
    field :create_user, :user_payload do
      arg(:user, non_null(:user_input))
      resolve(&Resolvers.UserResolver.create_user/3)
      middleware(&build_payload/2)
    end

    @desc "Send a invite to user"
    field :send_invite, list_of(:invite) do
      arg(:invite, non_null(list_of(:string)))
      middleware(Middleware.Authorize, :user)
      middleware(Middleware.SetATeam)
      resolve(&Resolvers.InviteResolver.send_invite/3)
    end

    @desc "Login with an user an then return a JWT"
    field :login, :login_payload do
      arg(:user, non_null(:login_input))
      resolve(&Resolvers.SessionResolver.login/3)
      middleware(&build_payload/2)
    end
  end
end
