# credo:disable-for-this-file
defmodule Opentelemetry.Proto.Metrics.V1.DataPointFlags do
  @moduledoc false
  (
    defstruct []

    (
      @spec default() :: :DATA_POINT_FLAGS_DO_NOT_USE
      def default() do
        :DATA_POINT_FLAGS_DO_NOT_USE
      end
    )

    @spec encode(atom() | String.t()) :: integer() | atom()
    [
      (
        def encode(:DATA_POINT_FLAGS_DO_NOT_USE) do
          0
        end

        def encode("DATA_POINT_FLAGS_DO_NOT_USE") do
          0
        end
      ),
      (
        def encode(:DATA_POINT_FLAGS_NO_RECORDED_VALUE_MASK) do
          1
        end

        def encode("DATA_POINT_FLAGS_NO_RECORDED_VALUE_MASK") do
          1
        end
      )
    ]

    def encode(x) do
      x
    end

    @spec decode(integer()) :: atom() | integer()
    [
      def decode(0) do
        :DATA_POINT_FLAGS_DO_NOT_USE
      end,
      def decode(1) do
        :DATA_POINT_FLAGS_NO_RECORDED_VALUE_MASK
      end
    ]

    def decode(x) do
      x
    end

    @spec constants() :: [{integer(), atom()}]
    def constants() do
      [{0, :DATA_POINT_FLAGS_DO_NOT_USE}, {1, :DATA_POINT_FLAGS_NO_RECORDED_VALUE_MASK}]
    end

    @spec has_constant?(any()) :: boolean()
    (
      [
        def has_constant?(:DATA_POINT_FLAGS_DO_NOT_USE) do
          true
        end,
        def has_constant?(:DATA_POINT_FLAGS_NO_RECORDED_VALUE_MASK) do
          true
        end
      ]

      def has_constant?(_) do
        false
      end
    )
  )
end
