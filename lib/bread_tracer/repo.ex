defmodule BreadTracer.Repo do
  use Ecto.Repo,
    otp_app: :bread_tracer,
    adapter: Ecto.Adapters.Postgres
end
