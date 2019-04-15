defmodule BreadTracerWeb.GraphQL.Fields.Expense do
  use Absinthe.Schema.Notation
  import Kronky.Payload
  import Absinthe.Resolution.Helpers, only: [dataloader: 1]
  alias BreadTracer.MoneyManagement
  alias BreadTracerWeb.GraphQL.Middleware.Authorize
  require IEx
  import BreadTracerWeb.GraphQL.Args.{Sortable, Searchable, Pagination}

  object :expense do
    field :active, :boolean
    field :amount, :integer
    field :frequency, :string
    field :name, :string
  end

  payload_object(:expense_payload, :expense)
  pagination_object(:paginated_expenses, :expense)

  ##########################
  # Queries
  #########################

  object :expense_queries do
    @desc "Get paginated list of expenses"
    field :expenses, :paginated_expenses do
      resolve(&list_expenses/3)
    end

    @desc "Get a single expense"
    field :expense, :expense do
      arg(:id, non_null(:id))

      resolve(&get_expense/3)
    end
  end

  ##########################
  # Mutations
  #########################

  object :expense_mutations do
    @desc "Create a expense"
    field :create_expense, type: :expense_payload do
      arg(:name, :string)
      arg(:amount, :string)
      arg(:frequency, :string)

      resolve(&create_expense/3)
      middleware(&build_payload/2)
    end

    @desc "Update a expense"
    field :update_expense, type: :expense_payload do
      arg(:id, :string)
      arg(:name, :string)
      arg(:amount, :string)
      arg(:frequency, :string)

      resolve(&update_expense/3)
      middleware(&build_payload/2)
    end

    @desc "Remove a expense"
    field :remove_expense, type: :expense_payload do
      arg(:id, :string)

      resolve(&remove_expense/3)
      middleware(&build_payload/2)
    end
  end

  ##########################
  # Resolvers
  #########################

  def list_expenses(_parent, args, _resolution) do
    {:ok, MoneyManagement.list_expenses()}
  end

  def get_expense(_parent, %{id: id} = args, _resolution) do
    case MoneyManagement.get_expense(id) do
      nil -> {:error, :not_found}
      expense -> {:ok, expense}
    end
  end

  def create_expense(_parent, args, _resolution) do
    case MoneyManagement.create_expense(args) do
      {:error, %Ecto.Changeset{} = changeset} -> {:ok, changeset}
      result -> result
    end
  end

  def update_expense(_parent, %{id: id} = args, _resolution) do
    case MoneyManagement.get_expense(id) do
      nil ->
        {:error, :not_found}

      expense ->
        case MoneyManagement.update_expense(expense, args) do
          {:error, %Ecto.Changeset{} = changeset} -> {:ok, changeset}
          result -> result
        end
    end
  end

  def remove_expense(_parent, %{id: id} = args, _resolution) do
    case MoneyManagement.get_expense(id) do
      nil ->
        {:error, :not_found}

      expense ->
        case MoneyManagement.delete_expense(expense) do
          {:error, %Ecto.Changeset{} = changeset} -> {:ok, changeset}
          result -> result
        end
    end
  end
end
