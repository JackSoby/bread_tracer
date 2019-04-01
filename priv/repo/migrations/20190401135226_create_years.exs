defmodule BreadTracer.Repo.Migrations.CreateYears do
  use Ecto.Migration

  def change do
    create table(:years) do
      add :name, :string
      add :goal, :integer
      add :total_saved, :integer
      add :active, :boolean, default: false, null: false
      add(:user_id, references(:users, on_delete: :nothing))

      timestamps()
    end
  end
end
