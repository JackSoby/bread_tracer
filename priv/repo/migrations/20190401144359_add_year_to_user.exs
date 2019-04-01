defmodule BreadTracer.Repo.Migrations.AddYearToUser do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add(:current_year_id, references(:years, on_delete: :nothing))
    end
  end
end
