defmodule PetaStackExample.Repo do
  use Ecto.Repo,
    otp_app: :peta_stack_example,
    adapter: Ecto.Adapters.Postgres
end
