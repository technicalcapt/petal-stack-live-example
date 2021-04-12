defmodule PetaStackExample.Repo.Migrations.AddUserRatingsTable do
  use Ecto.Migration

  def change do
    create table(:user_ratings) do
      add :name, :string
      add :quality, :integer

      timestamps()
    end
  end
end
