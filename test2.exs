cmd = ~S"""
ruby -e '
  STDOUT.sync = true
  context = binding
  while (cmd = gets) do
    eval(cmd, context)
  end
'
"""

port = Port.open({:spawn, cmd}, [:binary])

Port.command(port, "a = 1\n")
Port.command(port, "a += 2\n")
Port.command(port, "puts a\n")

receive do
  {^port, {:data, result}} ->
    IO.puts("Elixir got: #{inspect result}")
end
