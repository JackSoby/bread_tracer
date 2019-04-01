defmodule BreadTracer.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string
      add :password, :string
      add :first_name, :string
      add :last_name, :string
      add :email, :string
      add :monthly_income_after_taxes, :integer
      add :current_savings, :integer
      add :has_ira, :bool
      add :ira_percent, :float

      timestamps()
    end
  end
end
