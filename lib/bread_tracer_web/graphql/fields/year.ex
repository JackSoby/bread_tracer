defmodule BreadTracerWeb.GraphQL.Fields.Year do
  use Absinthe.Schema.Notation
  import Kronky.Payload
  import Absinthe.Resolution.Helpers, only: [dataloader: 1]
  alias BreadTracer.MoneyManagement
  alias BreadTracerWeb.GraphQL.Middleware.Authorize
  require IEx
  import BreadTracerWeb.GraphQL.Args.{Sortable, Searchable, Pagination}

  object :year do
    field :active, :boolean
    field :goal, :integer
    field :name, :string
    field :total_saved, :integer
  end

  payload_object(:year_payload, :year)
  pagination_object(:paginated_years, :year)

  ##########################
  # Queries
  #########################

  object :year_queries do
    @desc "Get paginated list of years"
    field :years, :paginated_years do
      resolve(&list_years/3)
    end

    @desc "Get a single year"
    field :year, :year do
      arg(:id, non_null(:id))

      resolve(&get_year/3)
    end
  end

  ##########################
  # Mutations
  #########################

  object :year_mutations do
    @desc "Create a year"
    field :create_year, type: :year_payload do
      arg(:active, :string)
      arg(:goal, :string)
      arg(:total_saved, :string)
      arg(:name, :string)

      resolve(&create_year/3)
      middleware(&build_payload/2)
    end

    @desc "Update a year"
    field :update_year, type: :year_payload do
      arg(:id, :string)
      arg(:active, :string)
      arg(:goal, :string)
      arg(:total_saved, :string)
      arg(:name, :string)

      resolve(&update_year/3)
      middleware(&build_payload/2)
    end

    @desc "Remove a year"
    field :remove_year, type: :year_payload do
      arg(:id, :string)

      resolve(&remove_year/3)
      middleware(&build_payload/2)
    end
  end

  ##########################
  # Resolvers
  #########################

  def list_years(_parent, args, _resolution) do
    {:ok, MoneyManagement.list_years(args)}
  end

  def get_year(_parent, %{id: id} = args, _resolution) do
    case MoneyManagement.get_year(id) do
      nil -> {:error, :not_found}
      year -> {:ok, year}
    end
  end

  def create_year(_parent, args, _resolution) do
    case MoneyManagement.create_year(args) do
      {:error, %Ecto.Changeset{} = changeset} -> {:ok, changeset}
      result -> result
    end
  end

  def update_year(_parent, %{id: id} = args, _resolution) do
    case MoneyManagement.get_year(id) do
      nil ->
        {:error, :not_found}

      year ->
        case MoneyManagement.update_year(year, args) do
          {:error, %Ecto.Changeset{} = changeset} -> {:ok, changeset}
          result -> result
        end
    end
  end

  def remove_year(_parent, %{id: id} = args, _resolution) do
    case MoneyManagement.get_year(id) do
      nil ->
        {:error, :not_found}

      year ->
        case MoneyManagement.delete_year(year) do
          {:error, %Ecto.Changeset{} = changeset} -> {:ok, changeset}
          result -> result
        end
    end
  end
end
