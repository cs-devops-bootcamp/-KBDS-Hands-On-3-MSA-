defmodule CompanyApi.ManufacturesTest do
  use CompanyApi.DataCase

  alias CompanyApi.Manufactures

  describe "lines" do
    alias CompanyApi.Manufactures.Line

    import CompanyApi.ManufacturesFixtures

    @invalid_attrs %{CallbackUrl: nil, MessageGroupId: nil}

    test "list_lines/0 returns all lines" do
      line = line_fixture()
      assert Manufactures.list_lines() == [line]
    end

    test "get_line!/1 returns the line with given id" do
      line = line_fixture()
      assert Manufactures.get_line!(line.id) == line
    end

    test "create_line/1 with valid data creates a line" do
      valid_attrs = %{CallbackUrl: "some CallbackUrl", MessageGroupId: "some MessageGroupId"}

      assert {:ok, %Line{} = line} = Manufactures.create_line(valid_attrs)
      assert line.CallbackUrl == "some CallbackUrl"
      assert line.MessageGroupId == "some MessageGroupId"
    end

    test "create_line/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Manufactures.create_line(@invalid_attrs)
    end

    test "update_line/2 with valid data updates the line" do
      line = line_fixture()
      update_attrs = %{CallbackUrl: "some updated CallbackUrl", MessageGroupId: "some updated MessageGroupId"}

      assert {:ok, %Line{} = line} = Manufactures.update_line(line, update_attrs)
      assert line.CallbackUrl == "some updated CallbackUrl"
      assert line.MessageGroupId == "some updated MessageGroupId"
    end

    test "update_line/2 with invalid data returns error changeset" do
      line = line_fixture()
      assert {:error, %Ecto.Changeset{}} = Manufactures.update_line(line, @invalid_attrs)
      assert line == Manufactures.get_line!(line.id)
    end

    test "delete_line/1 deletes the line" do
      line = line_fixture()
      assert {:ok, %Line{}} = Manufactures.delete_line(line)
      assert_raise Ecto.NoResultsError, fn -> Manufactures.get_line!(line.id) end
    end

    test "change_line/1 returns a line changeset" do
      line = line_fixture()
      assert %Ecto.Changeset{} = Manufactures.change_line(line)
    end
  end
end
