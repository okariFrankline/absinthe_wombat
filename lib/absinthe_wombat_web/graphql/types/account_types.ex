defmodule Absinthe.WombatWeb.Schema.AccountTypes do
  @moduledoc false
  use Absinthe.Schema.Notation
  alias Absinthe.WombatWeb.Schema.AccountResolver, as: Resolver

  @desc "A single user"
  object :user do
    field(:id, :id)
    field(:first_name, :string)
    field(:last_name, :string)
    field(:email, :string)
  end

  @desc "Input object for creating a new user"
  input_object :new_user_input do
    field(:email, non_null(:string))
    field(:last_name, non_null(:string))
    field(:first_name, non_null(:string))
  end

  @desc "Response object returned after a mutation operation"
  object :response do
    field(:message, non_null(:string))
    field(:success, :boolean)
  end

  @desc "User queries"
  object :user_queries do
    @desc "Returns a single user defined by a given id"
    field :user, :user do
      arg(:id, non_null(:id))

      resolve(&Resolver.get_user/3)
    end

    @desc "Returns a list of all the users"
    field :users, list_of(:user) do
      resolve(&Resolver.list_users/3)
    end
  end

  @desc "User mutations"
  object :user_mutations do
    @desc "Creates a given user given the email, first_name and last_name"
    field :new_user, :user do
      arg(:input, non_null(:new_user_input))

      resolve(&Resolver.create_user/3)
    end

    @desc "Deletes a given user identified by their id"
    field :delete_user, :response do
      arg(:id, non_null(:id))

      resolve(&Resolver.delete_user/3)
    end
  end
end
