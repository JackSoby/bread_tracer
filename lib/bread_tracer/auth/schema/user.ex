defmodule BreadTracer.Auth.Schema.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Bcrypt
  alias __MODULE__
  alias BreadTracer.MoneyManagement.Schema.Expense
  alias BreadTracer.MoneyManagement.Schema.Year

  schema "users" do
    field :password, :string
    field :username, :string
    field :first_name, :string
    field :last_name, :string
    field :email, :string
    field :monthly_income_after_taxes, :integer
    field :current_savings, :integer
    field :has_ira, :boolean
    field :ira_percent, :float
    has_many(:expenses, Expense)
    has_many(:years, Year)
    belongs_to(:current_year, Year)

    timestamps()
  end

  @doc false

  def changeset(%__MODULE__{} = user, attrs) do
    user
    |> cast(attrs, [
      :username,
      :first_name,
      :last_name,
      :email,
      :current_year_id,
      :monthly_income_after_taxes,
      :current_savings,
      :has_ira,
      :ira_percent,
      :password
    ])
    |> cast_assoc(:years)
    |> cast_assoc(:expenses)
    |> validate_required([:username, :password])
    |> put_password_hash()
  end

  defp put_password_hash(
         %Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset
       ) do
    change(changeset, password: Bcrypt.hash_pwd_salt(password))
  end

  defp put_password_hash(changeset), do: changeset
end
