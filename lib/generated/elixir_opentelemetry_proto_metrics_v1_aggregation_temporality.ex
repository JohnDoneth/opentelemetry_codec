# credo:disable-for-this-file
defmodule Opentelemetry.Proto.Metrics.V1.AggregationTemporality do
  @moduledoc false
  (
    defstruct []

    (
      @spec default() :: :AGGREGATION_TEMPORALITY_UNSPECIFIED
      def default() do
        :AGGREGATION_TEMPORALITY_UNSPECIFIED
      end
    )

    @spec encode(atom() | String.t()) :: integer() | atom()
    [
      (
        def encode(:AGGREGATION_TEMPORALITY_UNSPECIFIED) do
          0
        end

        def encode("AGGREGATION_TEMPORALITY_UNSPECIFIED") do
          0
        end
      ),
      (
        def encode(:AGGREGATION_TEMPORALITY_DELTA) do
          1
        end

        def encode("AGGREGATION_TEMPORALITY_DELTA") do
          1
        end
      ),
      (
        def encode(:AGGREGATION_TEMPORALITY_CUMULATIVE) do
          2
        end

        def encode("AGGREGATION_TEMPORALITY_CUMULATIVE") do
          2
        end
      )
    ]

    def encode(x) do
      x
    end

    @spec decode(integer()) :: atom() | integer()
    [
      def decode(0) do
        :AGGREGATION_TEMPORALITY_UNSPECIFIED
      end,
      def decode(1) do
        :AGGREGATION_TEMPORALITY_DELTA
      end,
      def decode(2) do
        :AGGREGATION_TEMPORALITY_CUMULATIVE
      end
    ]

    def decode(x) do
      x
    end

    @spec constants() :: [{integer(), atom()}]
    def constants() do
      [
        {0, :AGGREGATION_TEMPORALITY_UNSPECIFIED},
        {1, :AGGREGATION_TEMPORALITY_DELTA},
        {2, :AGGREGATION_TEMPORALITY_CUMULATIVE}
      ]
    end

    @spec has_constant?(any()) :: boolean()
    (
      [
        def has_constant?(:AGGREGATION_TEMPORALITY_UNSPECIFIED) do
          true
        end,
        def has_constant?(:AGGREGATION_TEMPORALITY_DELTA) do
          true
        end,
        def has_constant?(:AGGREGATION_TEMPORALITY_CUMULATIVE) do
          true
        end
      ]

      def has_constant?(_) do
        false
      end
    )
  )
end
