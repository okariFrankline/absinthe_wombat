defmodule Absinthe.Wombat.Accounts.User do
  @moduledoc false
  import Ecto.Changeset

  defstruct [
    :id,
    :first_name,
    :last_name,
    :email
  ]

  @type t :: %__MODULE__{
          first_name: String.t() | nil,
          last_name: String.t() | nil,
          email: String.t() | nil,
          id: binary() | nil
        }

  @types %{
    first_name: :string,
    last_name: :string,
    email: :string,
    id: :string
  }

  @doc false
  @spec new() :: t()
  def new, do: %__MODULE__{}

  @doc false
  @spec changeset(user, attrs) :: Ecto.Changeset.t()
        when user: t() | Ecto.Changeset.t(), attrs: map()
  def changeset(user, attrs) do
    cast({user, @types}, attrs, Map.keys(@types))
    |> validate_required([
      :first_name,
      :email,
      :last_name
    ])
    |> put_id()
  end

  @doc false
  @spec put_id(changeset :: Ecto.Changeset.t()) :: Ecto.Changeset.t()
  def put_id(changeset),
    do: changeset |> put_change(:id, Ecto.UUID.generate())
end
