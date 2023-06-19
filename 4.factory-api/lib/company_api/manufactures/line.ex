defmodule CompanyApi.Manufactures.Line do
  use Ecto.Schema
  import Ecto.Changeset

  schema "lines" do
    field :callback_url, :string
    field :message_group_id, :string

    timestamps()
  end

  @doc false
  def changeset(line, attrs) do
    line
    |> cast(attrs, [:MessageGroupId, :callback_url])
    |> validate_required([:MessageGroupId, :callback_url])
  end
end
