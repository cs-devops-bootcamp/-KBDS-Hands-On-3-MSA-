defmodule CompanyApi.FactoryWorkerSupervisor do
  use DynamicSupervisor
  alias CompanyApi.TopicAgentWorker

  @spec start_link(any) :: :ignore | {:error, any} | {:ok, pid}
  def start_link(_) do
    DynamicSupervisor.start_link(__MODULE__, :no_arges, name: __MODULE__)
  end

  def init(_) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end

  def add_worker(args) do
    {:ok, pid} = DynamicSupervisor.start_child(__MODULE__,
      {TopicAgentWorker, [args]}
    )
    IO.puts("add_worker")
    pid |> TopicAgentWorker.go_next
  end

end
