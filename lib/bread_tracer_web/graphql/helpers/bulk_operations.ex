defmodule BreadTracerWeb.GraphQL.Helpers.BulkOperations do
  import Kronky.Payload
  import Absinthe.Resolution.Helpers, only: [dataloader: 1]
  use Absinthe.Schema.Notation

  require IEx

  object :bulk_operation_response do
    field(:ok, :boolean)
    field(:num_errors, :integer)
  end

  def build_bulk_payload(%{value: value, errors: []} = resolution, _config) do
    payload =
      value
      |> Enum.map(fn changeset -> convert_to_payload(changeset) end)

    Absinthe.Resolution.put_result(resolution, {:ok, payload})
  end

  def build_bulk_payload(%{errors: errors} = resolution, _config) do
    result = convert_to_payload({:error, errors})
    Absinthe.Resolution.put_result(resolution, {:ok, result})
  end

  def build_bulk_payload(%{num_errors: num_errors} = resolution, _config) do
    result = convert_to_payload({:error, [resolution]})
    Absinthe.Resolution.put_result(resolution, {:ok, result})
  end
end
