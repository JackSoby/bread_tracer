defmodule BreadTracer.Repo do
  use Ecto.Repo,
    otp_app: :bread_tracer,
    adapter: Ecto.Adapters.Postgres

  use Scrivener, page_size: 10
end
