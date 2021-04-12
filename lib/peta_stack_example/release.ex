defmodule PetaStackExample.Release do
  @moduledoc """
  Contains functions which is called during deploy of release
  """
  @app :peta_stack_example

  def create_repos do
    load_app()

    for repo <- repos() do
      res = repo.__adapter__.storage_up(repo.config)

      res in [:ok, {:error, :already_up}] ||
        raise "The database for #{inspect(repo)} couldn't be created: #{inspect(res)}"
    end
  end

  def migrate do
    load_app()

    for repo <- repos() do
      {:ok, _, _} = Ecto.Migrator.with_repo(repo, &Ecto.Migrator.run(&1, :up, all: true))
    end
  end

  def rollback(repo, version) do
    load_app()
    {:ok, _, _} = Ecto.Migrator.with_repo(repo, &Ecto.Migrator.run(&1, :down, to: version))
  end

  defp repos do
    Application.fetch_env!(@app, :ecto_repos)
  end

  defp load_app do
    Application.load(@app)
  end
end
