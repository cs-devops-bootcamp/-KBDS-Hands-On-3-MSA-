defmodule CompanyApi.Repo.Migrations.CreateLines do
  use Ecto.Migration

  def change do
    create table(:lines) do
      add :MessageGroupId, :string
      add :CallbackUrl, :string

      timestamps()
    end
  end
end
