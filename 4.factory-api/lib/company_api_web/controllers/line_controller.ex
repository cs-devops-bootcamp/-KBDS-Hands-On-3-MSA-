defmodule CompanyApiWeb.LineController do
  use CompanyApiWeb, :controller

  alias CompanyApi.Manufactures
  alias CompanyApi.Manufactures.Line

  # action_fallback CompanyApiWeb.FallbackController

  def index(conn, _params) do
    lines = Manufactures.list_lines()
    render(conn, "index.json", lines: lines)
  end

  def create(conn, params) do
    req = %{
      id: UUID.uuid1(),
      reqestor: params["MessageAttributeRequester"],
      data: params
    }
    IO.inspect(req)
    CompanyApi.FactoryWorkerSupervisor.add_worker(req)

    conn
    |> put_status(:created)
    |> json(%{data: req})
  end

  def show(conn, %{"id" => id}) do
    line = Manufactures.get_line!(id)
    render(conn, "show.json", line: line)
  end

  def update(conn, %{"id" => id, "line" => line_params}) do
    line = Manufactures.get_line!(id)

    with {:ok, %Line{} = line} <- Manufactures.update_line(line, line_params) do
      render(conn, "show.json", line: line)
    end
  end

  def delete(conn, %{"id" => id}) do
    line = Manufactures.get_line!(id)

    with {:ok, %Line{}} <- Manufactures.delete_line(line) do
      send_resp(conn, :no_content, "")
    end
  end
end
