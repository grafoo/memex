defmodule Mix.Tasks.Db do
  use Mix.Task

  defp docker_start() do
    Mix.shell().cmd("docker start postgres")
  end

  defp docker_run() do
    command_args =
      [
        "-d",
        "--name postgres",
        "-v $(pwd)/pgdata:/var/lib/postgresql/data",
        "-e POSTGRES_PASSWORD=postgres",
        "-p 5432:5432",
        "postgres:14"
      ]
      |> List.foldl("", fn x, acc -> acc <> " " <> x end)

    Mix.shell().cmd("docker run " <> command_args)
  end

  @impl Mix.Task
  def run(args) do
    case hd(args) do
      "start" -> if docker_start() == 1, do: docker_run()
    end
  end
end
