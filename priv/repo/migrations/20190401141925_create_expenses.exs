defmodule BreadTracer.Repo.Migrations.CreateExpenses do
  use Ecto.Migration

  def change do
    create table(:expenses) do
      add :name, :string
      add :frequency, :string
      add :active, :boolean, default: false, null: false
      add :amount, :integer
      add(:user_id, references(:users, on_delete: :nothing))

      timestamps()
    end

  end
end
