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
    {:ok, pid} = Tachyon.JuliaWorker.start_link()

    Tachyon.JuliaWorker.call(pid, :println, ["BLOB"])
    |> IO.puts()

    Tachyon.JuliaWorker.call(pid, :println, ["Schlumpf"])
    |> IO.puts()
  end
end
