defmodule CompanyApi.TopicAgentWorker do
  use Agent

  def start_link(args) do
    Agent.start_link(fn -> {1, "시작", args} end)
  end

  @doc """
  tip. 꼭만들어야 한다. 그래야 Supervisor에서 자동으로 실행된다.CompanyApi.FactoryWorkerSupervisor.add_worker 할때 2일이나 걸렸다
  """
  def child_spec(args) do
    %{
      id: CompanyApi.TopicAgentWorker,
      start: {CompanyApi.TopicAgentWorker, :start_link, [args]},
      # 이 하나의 옵션으로 다시 agent가 살아날지 아닐지 결정한다.
      restart: :temporary
    }
  end

  @spec value(atom | pid | {atom, any} | {:via, atom, any}) :: any
  def value(pid) do
    Agent.get(pid, & &1)
  end

  def increment(pid) do
    Agent.update(pid, &(&1 + 1))
  end

  def go_next(pid) do
    IO.puts("go_next")
    IO.inspect(pid)
    # try do
    if Process.alive?(pid) do
      :timer.apply_after(10000, CompanyApi.TopicAgentWorker, :go_next, [pid])
    end
    Agent.update(
      pid,
      fn x ->
        IO.inspect(x)
        {code, msg, [data | _] } = x
        callbackUrl = data[:data]["CallbackUrl"]
        body = data[:data]
        IO.inspect({code, msg, data})

        if code == 99 do
          IO.inspect(callbackUrl)
          result =
            HTTPoison.post(
              # "http://localhost:4000/api/manufactures",
              callbackUrl,
              Jason.encode!(body),
              [{"Content-Type", "application/json"}]
            )
          Phoenix.PubSub.broadcast_from!(CompanyApi.PubSub, self(), "page", {:hello, "world"})
          Agent.stop(pid, :normal)
        end

        case x do
          # 작업시작
          {1, "시작", data} ->
            {2, "준비", data}

          # 생산중
          {2, "준비", data} ->
            {3, "생산", data}

          # 포장
          {3, "생산", data} ->
            {4, "포장", data}

          # 재고 추가
          {4, "포장", data} ->
            {99, "종료", data}
        end
      end
    )
    Phoenix.PubSub.broadcast_from!(CompanyApi.PubSub, self(), "page", {:hello, "world"})
  end
end

# CompanyApi.TopicAgent.start_link
