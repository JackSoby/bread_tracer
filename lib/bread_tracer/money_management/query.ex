defmodule BreadTracer.MoneyManagement.Query do
  import Ecto.Query, warn: false
  alias BreadTracer.MoneyManagement.Schema.Expense

  def handle_sort(Expense = queryable, params) do
    dir =
      case Map.get(params, :sort_desc) do
        nil -> :desc
        _ -> :asc
      end

    queryable
    |> order_by([u], [{^dir, u.priority}])
    |> order_by([u], desc: :id)
  end

  def handle_search(queryable, _params), do: queryable
end
