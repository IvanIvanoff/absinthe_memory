defmodule AbsintheMemoryWeb.Resolvers.MetricResolver do
  def get_metric(_parent, _args, _resolution) do
    {:ok, %{}}
  end

  def timeseries_data_per_asset(_parent, _args, _resolution) do
    # The heap size is in words, not bytes.
    # 50 megabytes in words is 50 * 1024 * 1024 divided by the wordsize
    heap_size_50_mb = div(50 * 1024 * 1024, :erlang.system_info(:wordsize))
    Process.flag(:max_heap_size, %{size: heap_size_50_mb, kill: true})

    assets = Enum.map(1..100, fn _ -> :crypto.strong_rand_bytes(8) |> Base.encode64() end)
    now = DateTime.utc_now()

    result =
      for i <- 1..200 do
        data = Enum.map(assets, fn asset -> %{asset: asset, value: :rand.uniform(100_000)} end)

        %{
          datetime: DateTime.add(now, -i * 60, :second),
          data: data
        }
      end

    {:ok, result}
  end
end
