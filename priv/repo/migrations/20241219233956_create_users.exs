defmodule Octos.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :full_name, :string, null: false
      add :email, :string, null: false
      add :document, :string, null: false
      add :document_type, :string, null: false
      add :hash_password, :text, null: false
      add :is_active, :boolean, default: true, null: false

      timestamps(type: :utc_datetime)
    end

    create unique_index(:users, [:email])
    create unique_index(:users, [:document, :document_type])
  end
end
