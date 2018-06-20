defmodule ShakeNBake do
  use Application

  @moduledoc """
  shake-n-bake application entry point
  """

  def start(_, _) do
    children = [
      %{
        id: ShakeNBake.Worker,
        start: {GenServer, :start_link, [ShakeNBake.Worker, []]}
      }
    ]

    opts = [
      strategy: :one_for_one,
      name: ShakeNBake.Supervisor
    ]

    Supervisor.start_link(children, opts)
  end
end
