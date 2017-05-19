defmodule Tachyon do
  @moduledoc """
  Documentation for Tachyon.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Tachyon.hello
      :world

  """
  def run() do
      IO.puts File.cwd!()
      {:ok, pid} = Tachyon.JuliaWorker.start_link()
      Tachyon.JuliaWorker.println(pid, "BLOB")
      |> IO.puts
      Tachyon.JuliaWorker.println(pid, "Schlumpf")
      |> IO.puts
  end
end
