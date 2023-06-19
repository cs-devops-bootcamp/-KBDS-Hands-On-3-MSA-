defmodule CompanyApi.CollectorsTest do
  use CompanyApi.DataCase

  alias CompanyApi.Collectors

  describe "events" do
    alias CompanyApi.Collectors.Event

    import CompanyApi.CollectorsFixtures

    @invalid_attrs %{body: nil, requestor: nil, type: nil}

    test "list_events/0 returns all events" do
      event = event_fixture()
      assert Collectors.list_events() == [event]
    end

    test "get_event!/1 returns the event with given id" do
      event = event_fixture()
      assert Collectors.get_event!(event.id) == event
    end

    test "create_event/1 with valid data creates a event" do
      valid_attrs = %{body: %{}, requestor: "some requestor", type: "some type"}

      assert {:ok, %Event{} = event} = Collectors.create_event(valid_attrs)
      assert event.body == %{}
      assert event.requestor == "some requestor"
      assert event.type == "some type"
    end

    test "create_event/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Collectors.create_event(@invalid_attrs)
    end

    test "update_event/2 with valid data updates the event" do
      event = event_fixture()
      update_attrs = %{body: %{}, requestor: "some updated requestor", type: "some updated type"}

      assert {:ok, %Event{} = event} = Collectors.update_event(event, update_attrs)
      assert event.body == %{}
      assert event.requestor == "some updated requestor"
      assert event.type == "some updated type"
    end

    test "update_event/2 with invalid data returns error changeset" do
      event = event_fixture()
      assert {:error, %Ecto.Changeset{}} = Collectors.update_event(event, @invalid_attrs)
      assert event == Collectors.get_event!(event.id)
    end

    test "delete_event/1 deletes the event" do
      event = event_fixture()
      assert {:ok, %Event{}} = Collectors.delete_event(event)
      assert_raise Ecto.NoResultsError, fn -> Collectors.get_event!(event.id) end
    end

    test "change_event/1 returns a event changeset" do
      event = event_fixture()
      assert %Ecto.Changeset{} = Collectors.change_event(event)
    end
  end
end
