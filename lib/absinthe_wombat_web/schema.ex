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
end
