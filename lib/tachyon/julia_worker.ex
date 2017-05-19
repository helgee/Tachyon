defmodule Tachyon.JuliaWorker do
    use GenServer

    @default_nprocs :erlang.system_info(:logical_processors_available)

    def println(pid, line) do
        GenServer.call(pid, {:println, line})
    end

    def start_link(opts \\ %{nprocs: @default_nprocs}) do
        GenServer.start_link(__MODULE__, opts)
    end

    def init(opts) do
        port = start_port()
        {:ok, %{port: port, next_id: 1, awaiting: %{}}}
    end

    def handle_call({:println, line}, from, state) do
        {id, state} = send_request(state, line)
        {:noreply, %{state | awaiting: Map.put(state.awaiting, id, from)}}
    end

    def handle_info({port, {:data, response}}, %{port: port} = state) do
        case String.split(response, ":", parts: 2) do
            [id, result] ->
                id = Integer.parse(id)
                case state.awaiting[id] do
                    nil -> {:noreply, state}
                    caller ->
                        IO.puts caller
                        GenServer.reply(caller, result)
                        {:noreply, %{state | awaiting: Map.delete(state.awaitng, id)}}
                end
            [msg] ->
                IO.puts msg
                {:noreply, state}
        end
    end

    def handle_info({port, {:exit_status, status}}, %{port: port}) do
        :erlang.error({:port_exit, status})
    end

    def handle_info(_, state), do: {:noreply, state}

    defp start_port do
        Port.open({:spawn, "julia julia/worker.jl"}, [:binary])
    end

    defp command(id, line) do
        "{\"id\":#{id}\"line\":\"#{line}\"}\n"
    end

    defp send_request(state, line) do
        id = state.next_id
        cmd = command(id, line)
        Port.command(state.port, cmd)
        {id, %{state | next_id: id + 1}}
    end
end
