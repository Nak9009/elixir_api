defmodule ElixirApi.Repo.Migrations.AddPasswordAndRoleToUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :password_hash, :string
      add :role, :string, default: "user"
    end
  end
end
