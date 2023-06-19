defmodule CompanyApiWeb.LineView do
  use CompanyApiWeb, :view
  alias CompanyApiWeb.LineView

  def render("index.json", %{lines: lines}) do
    %{data: render_many(lines, LineView, "line.json")}
  end

  def render("show.json", %{line: line}) do
    %{data: render_one(line, LineView, "line.json")}
  end

  def render("line.json", %{line: line}) do
    %{
      id: line.id,
      message_group_id: line.message_group_id,
      callback_url: line.callback_url
    }
  end
end
