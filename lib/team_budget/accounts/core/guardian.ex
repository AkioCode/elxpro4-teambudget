defmodule TeamBudget.Accounts.Core.Guardian do
  use Guardian, otp_app: :team_budget

  def subject_for_token(resource, _claims) do
    # You can use any value for the subject of your token but
    # it should be useful in retrieving the resource later, see
    # how it being used on `resource_from_claims/1` function.
    # A unique `id` is a good subject, a non-unique email address
    # is a poor subject.
    sub = to_string(resource.id)
    {:ok, sub}
  end

  def subject_for_token(_, _) do
    {:error, :reason_for_error}
  end

  def resource_from_claims(%{"sub" => id}) do
    # Here we'll look up our resource from the claims, the subject can be
    # found in the `"sub"` key. In `above subject_for_token/2` we returned
    # the resource id so here we'll rely on that to look it up.
    resource = TeamBudget.Accounts.Core.UserRepo.get_user!(id)
    {:ok, resource}
  end

  def resource_from_claims(_claims) do
    {:error, :reason_for_error}
  end

  def sign_in(%TeamBudget.Accounts.Data.User{} = user),
    do: Guardian.encode_and_sign(__MODULE__, user)

  def verify(token), do: Guardian.decode_and_verify(__MODULE__, token)
end
