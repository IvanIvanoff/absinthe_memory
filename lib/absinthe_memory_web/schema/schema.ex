defmodule AbsintheMemoryWeb.Schema do
  use Absinthe.Schema

  import_types(AbsintheMemoryWeb.CustomTypes.DateTime)
  import_types(AbsintheMemoryWeb.Schema.MetricTypes)

  alias AbsintheMemoryWeb.Resolvers

  query do
    field :get_metric, :metric do
      resolve(&Resolvers.MetricResolver.get_metric/3)
    end
  end
end
