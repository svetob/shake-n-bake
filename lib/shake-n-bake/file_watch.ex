defmodule ShakeNBake.FileWatch do
  @moduledoc """
  Poll files to detect changes
  """

  def last_modified(paths) do
    paths
    |> modified()
    |> List.flatten()
    |> Enum.sort()
    |> Enum.reverse()
    |> List.first()
  end

  def modified([]) do
    []
  end

  def modified([path | tail]) do
    if File.dir?(path) do
      [traverse(path) | modified(tail)]
    else
      [stat(path) | modified(tail)]
    end
  end

  defp traverse(dir) do
    case File.ls(dir) do
      {:ok, files} ->
        files
        |> Enum.map(fn file ->
          Path.join(dir, file)
        end)
        |> modified()

      {:error, reason} ->
        []
    end
  end

  defp stat(file) do
    case File.stat(file, time: :posix) do
      {:ok, %File.Stat{mtime: mtime}} ->
        [mtime]

      {:error, reason} ->
        []
    end
  end
end
