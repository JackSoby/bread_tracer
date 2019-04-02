defmodule BreadTracerWeb.GraphQL.Args.Project do
  use Absinthe.Schema.Notation

  defmacro project_args() do
    quote do
      arg(:id, :string)
      arg(:name, :string)
      arg(:client_id, :id)
      arg(:is_active, :boolean)

      arg(:pivotal_tracker_id, :string)

      arg(:project_purpose, :string)
      arg(:bowst_purpose, :string)
      arg(:description, :string)
      arg(:scope, :integer)
      arg(:start_date, :date)
      arg(:launch_date, :date)
      arg(:project_documents, list_of(:project_document_input))
    end
  end
end
