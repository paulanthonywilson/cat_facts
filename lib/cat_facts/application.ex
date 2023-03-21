defmodule CatFacts.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {Finch, name: CatFinch}
    ]

    opts = [strategy: :one_for_one, name: CatFacts.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
