defmodule Absinthe.Wombat.Repo.Store do
  @moduledoc false
  alias Absinthe.Wombat.Accounts.User

  @doc false
  @spec init() :: __MODULE__
  def init do
    :ets.new(__MODULE__, [:named_table, :public, :set])
  end

  @doc """
  Inserts a new user to the ets table

  ## Examples
      iex> store_user(user)
      :true
  """
  @spec store_user(user :: User.t()) :: true
  def store_user(%User{id: id} = user), do: :ets.insert(__MODULE__, {id, user})

  @doc """
  Returns a list of all the users stored in the ets table

  ## Examples
      iex> all_users()
      [%User{}]

  """
  @spec all_users() :: [User.t()]
  def all_users do
    case :ets.tab2list(__MODULE__) do
      [] ->
        []

      result when result != [] ->
        result
        |> Enum.map(&elem(&1, 1))
    end
  end

  @doc """
  Returns the details of a user based on their id

  ## Examples
      iex> find_user(user_id)
      %User{}

      iex> find_user(unknown_user_id)
      nil

  """
  @spec find_user(user_id :: binary()) :: User.t() | nil
  def find_user(user_id) when is_binary(user_id) do
    case :ets.lookup(__MODULE__, user_id) do
      [{_id, %User{} = user}] -> user
      [] -> nil
    end
  end

  @doc """
  Deletes a specified user

  ## Examples
      iex> delete_user(user)
      :ok

  """
  @spec delete_user(user_id :: binary()) :: :ok
  def delete_user(user_id) when is_binary(user_id) do
    :ets.delete(__MODULE__, user_id)
    :ok
  end
end
