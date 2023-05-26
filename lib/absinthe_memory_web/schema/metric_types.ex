defmodule AbsintheMemoryWeb.Schema.MetricTypes do
  use Absinthe.Schema.Notation
  alias AbsintheMemoryWeb.Resolvers

  object :metric do
    field :timeseries_data_per_asset, list_of(:timeseries_data_per_asset) do
      resolve(&Resolvers.MetricResolver.timeseries_data_per_asset/3)
    end
  end

  object :asset_data do
    field :asset, :string
    field :value, :float
  end

  object :timeseries_data_per_asset do
    field :datetime, :datetime
    field :data, list_of(:asset_data)
  end
end
