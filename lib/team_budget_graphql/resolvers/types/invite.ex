defmodule TeamBudgetGraphql.Types.Invite do
  use Absinthe.Schema.Notation

  object :invite do
    field :id, :string
    field :team_id, :string
    field :user_id, :string
    field :email, :string
    field :account_has_email, :boolean
  end

  input_object :invite_input do
    field :team_id, non_null(:string)
    field :user_id, non_null(:string)
    field :email, non_null(:string)
    field :account_has_email, non_null(:boolean)
  end
end
