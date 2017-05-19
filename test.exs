port = Port.open({:spawn, "julia julia/worker.jl"}, [:binary])

Port.command(port, "a = 1\n")
Port.command(port, "a += 2\n")
Port.command(port, "puts a\n")

receive do
  {^port, {:data, result}} ->
    IO.puts("Elixir got: #{inspect result}")
end
