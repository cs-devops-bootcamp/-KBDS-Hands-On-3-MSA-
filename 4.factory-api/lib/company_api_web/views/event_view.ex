defmodule CompanyApiWeb.EventView do
  use CompanyApiWeb, :view
  alias CompanyApiWeb.EventView

  def render("index.json", %{events: events}) do
    %{data: render_many(events, EventView, "event.json")}
  end

  def render("show.json", %{event: event}) do
    %{data: render_one(event, EventView, "event.json")}
  end

  def render("event.json", %{event: event}) do
    %{
      id: event.id,
      requestor: event.requestor,
      body: event.body,
      type: event.type
    }
  end
end
