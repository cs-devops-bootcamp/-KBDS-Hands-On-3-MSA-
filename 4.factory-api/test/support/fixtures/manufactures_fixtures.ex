defmodule CompanyApi.ManufacturesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `CompanyApi.Manufactures` context.
  """

  @doc """
  Generate a line.
  """
  def line_fixture(attrs \\ %{}) do
    {:ok, line} =
      attrs
      |> Enum.into(%{
        CallbackUrl: "some CallbackUrl",
        MessageGroupId: "some MessageGroupId"
      })
      |> CompanyApi.Manufactures.create_line()

    line
  end
end
