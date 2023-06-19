defmodule CompanyApiWeb.FectoryStepView do
    use Phoenix.LiveView


    def render(assigns) do
        ~L"""
            <div class="">
            <table>
            <thead>
              <tr>
                <th>pid</th>
                <th>requester</th>
                <th>code</th>
                <th>message</th>
                <th>callback</th>
                <th>action</th>
                </tr>
            </thead>
            <tbody>

            <%= for {id, pid, code, msg, requester, callbackUrl, data, type} <- @list do            %>
            <tr>
              <td><%=pid %></td>
              <td><%=requester %></td>
              <td><%=code %></td>
              <td><%=msg %>..</td>
              <td><%=callbackUrl %></td>
              <td><button phx-click="go_next" phx-value-pid="<%=pid %>">Go 1 Step</button></td>
            </tr>
        <% end %>

            </tbody>
          </table>

            </div>
        """
    end

    def mount(_session, _, socket) do
        if connected?(socket) do
            Phoenix.PubSub.subscribe(CompanyApi.PubSub, "page")
        end

        list = Supervisor.which_children(CompanyApi.FactoryWorkerSupervisor)
        |> Enum.map(fn ({id, pid, type, module}) ->
            value = CompanyApi.TopicAgentWorker.value(pid)
            {code, msg, [data | _] } = value
            callbackUrl = data[:data]["CallbackUrl"]
            requester = data[:data]["MessageAttributeRequester"]

            {id, pid2str(pid), code, msg, requester, callbackUrl, data, type}
            # , module |> Enum.join(", ")
        end )
        IO.inspect(list)

        {:ok, assign(socket, list: list )}


    end
    def handle_info({:hello, _}, socket) do
        list = Supervisor.which_children(CompanyApi.FactoryWorkerSupervisor)
        |> Enum.map(fn ({id, pid, type, module}) ->
            {id, pid2str(pid), inspect(
                CompanyApi.TopicAgentWorker.value(pid)
                ), type, module |> Enum.join(", ")}
        end )
        {:noreply, push_event(socket, "list", :maps.from_list(list))}
    end


    def handle_event("add_worker", value, socket) do
        IO.inspect(value)
        list = Supervisor.which_children(CompanyApi.FactoryWorkerSupervisor)
        |> Enum.map(fn ({id, pid, type, module}) ->

            {id, pid2str(pid), inspect(
                CompanyApi.TopicAgentWorker.value(pid)
                ), type, module |> Enum.join(", ")}
        end )
        IO.inspect(list, socket)
        CompanyApi.FactoryWorkerSupervisor.add_worker('worker_1')
        {:noreply, assign(socket, list: list) }
    end

    defp pid2str(pid) do
        pid |> :erlang.pid_to_list() |> List.delete_at(0) |> List.delete_at(-1) |> to_string()
    end

    def handle_event("go_next", %{"pid" => pid_str, "value" => ""}, socket) do
        IO.puts("go_next")
        IO.inspect(pid_str)
        IEx.Helpers.pid(pid_str) |> CompanyApi.TopicAgentWorker.go_next
        list = Supervisor.which_children(CompanyApi.FactoryWorkerSupervisor)
        |> Enum.map(fn ({id, pid, type, module}) ->
            {code, msg, [data | _] } =  CompanyApi.TopicAgentWorker.value(pid)
            callbackUrl = data[:data]["CallbackUrl"]
            requester = data[:data]["MessageAttributeRequester"]

            {id, pid2str(pid), code, msg, requester, callbackUrl, data, type}

        end )
        {:noreply, assign(socket, list: list) }
    end

end
