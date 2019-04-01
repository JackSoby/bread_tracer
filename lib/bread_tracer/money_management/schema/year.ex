defmodule BreadTracer.MoneyManagement.Schema.Year do
  use Ecto.Schema
  import Ecto.Changeset
  alias BreadTracer.Auth.Schema.User

  schema "years" do
    field :active, :boolean, default: false
    field :goal, :integer
    field :name, :string
    field :total_saved, :integer
    belongs_to(:user, User)

    timestamps()
  end

  @doc false
  def changeset(year, attrs) do
    year
    |> cast(attrs, [:name, :goal, :total_saved, :active])
    |> validate_required([:name, :goal, :active])
  end
end
