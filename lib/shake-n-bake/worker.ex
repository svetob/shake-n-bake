defmodule ShakeNBake.Worker do
  use GenServer

  require Logger

  alias ShakeNBake.FileWatch

  @moduledoc """
  Worker which polls file system at regular intervals and runs tasks on changes.
  """

  @interval 1_000

  def init(_args) do
    Process.send_after(self(), :shake, 5_000)
    {:ok, now()}
  end

  def handle_info(:shake, state) do
    latest_change = FileWatch.last_modified(source_paths())

    if latest_change > state do
      bake()
      Process.send_after(self(), :shake, @interval)
      {:noreply, latest_change}
    else
      Process.send_after(self(), :shake, @interval)
      {:noreply, state}
    end
  end

  @doc """
  Run tasks (compiler, tests)
  """
  def bake do
    run_compile()

    if run_tests?() do
      run_tests()
    end
  end

  def run_compile do
    Mix.Tasks.Compile.Elixir.run(["--ignore-module-conflict"])
  end

  def run_tests do
    test_cmd()
    |> String.to_charlist()
    |> :os.cmd()
    |> IO.puts()
  end

  defp source_paths, do: Application.get_env(:shake_n_bake, :paths, ["./lib"])

  defp run_tests?, do: Application.get_env(:shake_n_bake, :run_tests, true)

  defp test_cmd, do: Application.get_env(:shake_n_bake, :test_cmd, "mix test")

  defp now, do: System.os_time(:second)
end
