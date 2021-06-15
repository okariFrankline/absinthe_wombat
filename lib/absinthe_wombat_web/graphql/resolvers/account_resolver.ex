defmodule Absinthe.WombatWeb.Schema.AccountResolver do
  @moduledoc false
  alias Absinthe.Wombat.Accounts
  alias Absinthe.Wombat.Accounts.User

  @doc false
  def create_user(_parent, %{input: user_params}, _resolution) do
    with {:ok, %User{} = user} <- Accounts.create_user(user_params) do
      {:ok, user}
    end
  end

  @doc false
  def list_users(_parent, _input, _resolution) do
    {:ok, Accounts.all_users()}
  end

  @doc false
  def get_user(_parent, %{id: id}, _resolution) do
    with {:ok, %User{} = user} <- Accounts.get_user(id) do
      {:ok, user}
    end
  end

  @doc false
  def delete_user(_parent, %{id: id}, _resolution) do
    :ok = Accounts.delete_user(id)

    response = %{
      message: "User successfully deleted",
      success: true
    }

    {:ok, response}
  end
end
