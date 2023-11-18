# credo:disable-for-this-file
defmodule Opentelemetry.Proto.Logs.V1.LogRecordFlags do
  @moduledoc false
  (
    defstruct []

    (
      @spec default() :: :LOG_RECORD_FLAGS_DO_NOT_USE
      def default() do
        :LOG_RECORD_FLAGS_DO_NOT_USE
      end
    )

    @spec encode(atom() | String.t()) :: integer() | atom()
    [
      (
        def encode(:LOG_RECORD_FLAGS_DO_NOT_USE) do
          0
        end

        def encode("LOG_RECORD_FLAGS_DO_NOT_USE") do
          0
        end
      ),
      (
        def encode(:LOG_RECORD_FLAGS_TRACE_FLAGS_MASK) do
          255
        end

        def encode("LOG_RECORD_FLAGS_TRACE_FLAGS_MASK") do
          255
        end
      )
    ]

    def encode(x) do
      x
    end

    @spec decode(integer()) :: atom() | integer()
    [
      def decode(0) do
        :LOG_RECORD_FLAGS_DO_NOT_USE
      end,
      def decode(255) do
        :LOG_RECORD_FLAGS_TRACE_FLAGS_MASK
      end
    ]

    def decode(x) do
      x
    end

    @spec constants() :: [{integer(), atom()}]
    def constants() do
      [{0, :LOG_RECORD_FLAGS_DO_NOT_USE}, {255, :LOG_RECORD_FLAGS_TRACE_FLAGS_MASK}]
    end

    @spec has_constant?(any()) :: boolean()
    (
      [
        def has_constant?(:LOG_RECORD_FLAGS_DO_NOT_USE) do
          true
        end,
        def has_constant?(:LOG_RECORD_FLAGS_TRACE_FLAGS_MASK) do
          true
        end
      ]

      def has_constant?(_) do
        false
      end
    )
  )
end
