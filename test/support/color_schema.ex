defmodule ColorSchema do
  use Absinthe.Schema

  @names %{
    r: "RED",
    g: "GREEN",
    b: "BLUE",
    p: "PUCE"
  }

  @values %{
    r: 100,
    g: 200,
    b: 300,
    p: -100
  }

  query do

    field :info,
      type: :channel_info,
      args: [
        channel: [type: non_null(:channel)],
      ],
      resolve: fn
        %{channel: channel}, _ ->
          {:ok, %{name: @names[channel], value: @values[channel]}}
      end

  end

  @desc """
  A color channel
  """
  enum :channel do
    value :red, description: "The color red", as: :r
    value :green, description: "The color green", as: :g
    value :blue, description: "The color blue", as: :b
    value :puce, description: "The color puce", as: :p, deprecate: "it's ugly"
  end

  @desc """
  Info about a channel
  """
  object :channel_info do
    field :name, :string
    field :value, :integer
  end

end
