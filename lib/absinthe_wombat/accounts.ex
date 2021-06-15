defmodule Absinthe.Wombat.Accounts do
  @moduledoc false
  alias __MODULE__.User
  ## TO DO: Create the Absinthe.Wombat.Store
  alias Absinthe.Wombat.Repo.Store

  @type success :: {:ok, User.t()}
  @type failure :: {:error, Ecto.Changeset.t()}

  @doc """
  Creates a new user

  ## Examples
      iex> create_user(valid_params)
      {:ok, %User{}}

      iex> create_user(invalid_params)
      {:error, %Ecto.Changeset{}}
  """
  @spec create_user(attrs :: map()) :: success() | failure()
  def create_user(attrs) do
    User.new()
    |> User.changeset(attrs)
    |> case do
      %{valid?: true} = changeset ->
        user =
          changeset
          |> Ecto.Changeset.apply_action!(:insert)

        ## TO DO: Define the Store.store_user/1
        Store.store_user(user)

        {:ok, user}

      changeset ->
        {:error, changeset}
    end
  end

  @doc """
  Lists all the users in the system

  ## Examples
      iex> all_users()
      [%User{}]

  """
  @spec all_users() :: [User.t()]
  def all_users, do: Store.all_users()

  @doc """
  Returns a single user based on their id

  ## Examples
    iex> get_user(user_id)
    {:ok, %User{}}

    iex> get_user(non_existing_user)
    {:error, :not_found}

  """
  @spec get_user(user_id :: binary()) :: {:ok, User.t()} | {:error, :not_found}
  def get_user(user_id) when is_binary(user_id) do
    if user = Store.find_user(user_id), do: {:ok, user}, else: {:error, :not_found}
  end

  @doc """
  Deletes a user.

  ## Examples
      iex> delete_user(user)
      :ok
  """
  @spec delete_user(user_id :: binary()) :: :ok
  def delete_user(user_id) when is_binary(user_id), do: Store.delete_user(user_id)
end
