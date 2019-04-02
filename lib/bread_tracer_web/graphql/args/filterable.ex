defmodule BreadTracerWeb.GraphQL.Args.Filterable do
  use Absinthe.Schema.Notation

  defmacro filterable_args() do
    quote do
      arg(:is_active, :boolean)
    end
  end
end
