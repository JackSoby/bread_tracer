defmodule BreadTracerWeb.GraphQL.Schema do
  use Absinthe.Schema

  # App Contexts
  alias BreadTracer.{Auth, MoneyManagement}

  import Absinthe.Resolution.Helpers

  # Libraries
  import_types(Absinthe.Type.Custom)
  import_types(Kronky.ValidationMessageTypes)

  # Custom Scalars
  import_types(BreadTracerWeb.GraphQL.Helpers.JSON)

  # Types and Fields (e.g. queries and mutations)
  import_types(BreadTracerWeb.GraphQL.Fields.Expense)

  input_object :project_document_input do
    field(:id, :id)
    field(:name, :string)
    field(:url, :string)
  end

  query do
    import_fields(:expense_queries)
  end

  mutation do
    import_fields(:expense_mutations)
  end

  # Context Callbacks
  def context(ctx) do
    loader =
      Dataloader.new()
      |> Dataloader.add_source(Auth, Auth.data())
      |> Dataloader.add_source(MoneyManagement, MoneyManagement.data())

    Map.put(ctx, :loader, loader)
  end

  def plugins do
    [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  end
end
