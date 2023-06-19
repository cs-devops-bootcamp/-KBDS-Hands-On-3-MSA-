defmodule CompanyApiWeb.LineControllerTest do
  use CompanyApiWeb.ConnCase

  import CompanyApi.ManufacturesFixtures

  alias CompanyApi.Manufactures.Line

  @create_attrs %{
    CallbackUrl: "some CallbackUrl",
    MessageGroupId: "some MessageGroupId"
  }
  @update_attrs %{
    CallbackUrl: "some updated CallbackUrl",
    MessageGroupId: "some updated MessageGroupId"
  }
  @invalid_attrs %{CallbackUrl: nil, MessageGroupId: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all lines", %{conn: conn} do
      conn = get(conn, Routes.line_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create line" do
    test "renders line when data is valid", %{conn: conn} do
      conn = post(conn, Routes.line_path(conn, :create), line: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.line_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "CallbackUrl" => "some CallbackUrl",
               "MessageGroupId" => "some MessageGroupId"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.line_path(conn, :create), line: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update line" do
    setup [:create_line]

    test "renders line when data is valid", %{conn: conn, line: %Line{id: id} = line} do
      conn = put(conn, Routes.line_path(conn, :update, line), line: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.line_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "CallbackUrl" => "some updated CallbackUrl",
               "MessageGroupId" => "some updated MessageGroupId"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, line: line} do
      conn = put(conn, Routes.line_path(conn, :update, line), line: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete line" do
    setup [:create_line]

    test "deletes chosen line", %{conn: conn, line: line} do
      conn = delete(conn, Routes.line_path(conn, :delete, line))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.line_path(conn, :show, line))
      end
    end
  end

  defp create_line(_) do
    line = line_fixture()
    %{line: line}
  end
end
