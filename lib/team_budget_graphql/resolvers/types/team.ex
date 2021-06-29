defmodule TeamBudgetGraphql.Types.Team do
  use Absinthe.Schema.Notation

  object :team do
    field :id, :string
    field :name, :string
    field :description, :string
    field :slug, :string
    field :user_id, :string
    field :user, :user
  end

  input_object :team_input do
    field :name, non_null(:string)
    field :description, non_null(:string)
  end
end
