defmodule AbsintheMemory.Repo do
  use Ecto.Repo,
    otp_app: :absinthe_memory,
    adapter: Ecto.Adapters.Postgres
end
