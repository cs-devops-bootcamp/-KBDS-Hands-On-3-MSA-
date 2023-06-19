defmodule CompanyApi.CollectorsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `CompanyApi.Collectors` context.
  """

  @doc """
  Generate a event.
  """
  def event_fixture(attrs \\ %{}) do
    {:ok, event} =
      attrs
      |> Enum.into(%{
        body: %{},
        requestor: "some requestor",
        type: "some type"
      })
      |> CompanyApi.Collectors.create_event()

    event
  end
end
