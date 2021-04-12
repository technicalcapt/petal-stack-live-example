defmodule PetaStackExample.Users do
  @moduledoc """
  Users context
  """

  alias PetaStackExample.UserRating
  alias PetaStackExample.Repo

  @doc """
  Returns list of user rating

  ## Examples

      iex> list_user_ratings()
      [%UserRating{}, ...]
  """
  def list_user_ratings do
    Repo.all(UserRating)
  end

  @doc """
  Returns a data structure for tracking user rating changes.

  ## Examples

      iex> user_rating_changeset(work)
      %Changeset{...}

  """
  def user_rating_changeset(%UserRating{} = user_rating, attrs \\ %{}) do
    UserRating.changeset(user_rating, attrs)
  end

  @doc """
  Creates an user rating.

  ## Examples

      iex> create_user_rating(%{field: value})
      {:ok, %UserRating{}}

      iex> create_user_rating(%{field: bad_value})
      {:error, ...}

  """
  def create_user_rating(attrs) do
    %UserRating{}
    |> UserRating.changeset(attrs)
    |> Repo.insert()
  end
end
