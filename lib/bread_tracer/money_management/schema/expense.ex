defmodule BreadTracer.MoneyManagement.Schema.Expense do
  use Ecto.Schema
  import Ecto.Changeset
  alias BreadTracer.Auth.Schema.User

  schema "expenses" do
    field :active, :boolean, default: false
    field :amount, :integer
    field :frequency, :string
    field :name, :string
    belongs_to(:user, User)

    timestamps()
  end

  @doc false
  def changeset(expense, attrs) do
    expense
    |> cast(attrs, [:name, :frequency, :active, :amount])
    |> validate_required([:name, :frequency, :active, :amount])
  end
end
