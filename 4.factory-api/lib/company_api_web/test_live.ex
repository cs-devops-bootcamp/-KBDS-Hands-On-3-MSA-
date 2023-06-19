defmodule CompanyApiWeb.TestLive do
  # In Phoenix v1.6+ apps, the line below should be: use MyAppWeb, :live_view
  use Phoenix.LiveView

  @spec render(any) :: Phoenix.LiveView.Rendered.t()
  def render(assigns) do
    ~H"""
    Current temperature: <%= @temperature %>
    """
  end

  def mount(_params, _, socket) do
    temperature = 1
    {:ok, assign(socket, :temperature, temperature)}
  end
end
