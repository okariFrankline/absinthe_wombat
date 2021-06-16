defmodule Absinthe.WombatWeb.Schema do
  @moduledoc false
  use Absinthe.Schema

  import_types(Absinthe.Type.Custom)
  import_types(__MODULE__.AccountTypes)

  ## queries
  query do
    import_fields(:user_queries)
  end

  ## mutations
  mutation do
    import_fields(:user_mutations)
  end

  ## subscription
  subscription do
    field :user_created, :user do
      config(fn _args, _info ->
        {:ok, topic: "*"}
      end)
    end
  end
end
