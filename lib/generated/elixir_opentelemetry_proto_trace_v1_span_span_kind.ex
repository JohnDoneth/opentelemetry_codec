# credo:disable-for-this-file
defmodule Opentelemetry.Proto.Trace.V1.Span.SpanKind do
  @moduledoc false
  (
    defstruct []

    (
      @spec default() :: :SPAN_KIND_UNSPECIFIED
      def default() do
        :SPAN_KIND_UNSPECIFIED
      end
    )

    @spec encode(atom() | String.t()) :: integer() | atom()
    [
      (
        def encode(:SPAN_KIND_UNSPECIFIED) do
          0
        end

        def encode("SPAN_KIND_UNSPECIFIED") do
          0
        end
      ),
      (
        def encode(:SPAN_KIND_INTERNAL) do
          1
        end

        def encode("SPAN_KIND_INTERNAL") do
          1
        end
      ),
      (
        def encode(:SPAN_KIND_SERVER) do
          2
        end

        def encode("SPAN_KIND_SERVER") do
          2
        end
      ),
      (
        def encode(:SPAN_KIND_CLIENT) do
          3
        end

        def encode("SPAN_KIND_CLIENT") do
          3
        end
      ),
      (
        def encode(:SPAN_KIND_PRODUCER) do
          4
        end

        def encode("SPAN_KIND_PRODUCER") do
          4
        end
      ),
      (
        def encode(:SPAN_KIND_CONSUMER) do
          5
        end

        def encode("SPAN_KIND_CONSUMER") do
          5
        end
      )
    ]

    def encode(x) do
      x
    end

    @spec decode(integer()) :: atom() | integer()
    [
      def decode(0) do
        :SPAN_KIND_UNSPECIFIED
      end,
      def decode(1) do
        :SPAN_KIND_INTERNAL
      end,
      def decode(2) do
        :SPAN_KIND_SERVER
      end,
      def decode(3) do
        :SPAN_KIND_CLIENT
      end,
      def decode(4) do
        :SPAN_KIND_PRODUCER
      end,
      def decode(5) do
        :SPAN_KIND_CONSUMER
      end
    ]

    def decode(x) do
      x
    end

    @spec constants() :: [{integer(), atom()}]
    def constants() do
      [
        {0, :SPAN_KIND_UNSPECIFIED},
        {1, :SPAN_KIND_INTERNAL},
        {2, :SPAN_KIND_SERVER},
        {3, :SPAN_KIND_CLIENT},
        {4, :SPAN_KIND_PRODUCER},
        {5, :SPAN_KIND_CONSUMER}
      ]
    end

    @spec has_constant?(any()) :: boolean()
    (
      [
        def has_constant?(:SPAN_KIND_UNSPECIFIED) do
          true
        end,
        def has_constant?(:SPAN_KIND_INTERNAL) do
          true
        end,
        def has_constant?(:SPAN_KIND_SERVER) do
          true
        end,
        def has_constant?(:SPAN_KIND_CLIENT) do
          true
        end,
        def has_constant?(:SPAN_KIND_PRODUCER) do
          true
        end,
        def has_constant?(:SPAN_KIND_CONSUMER) do
          true
        end
      ]

      def has_constant?(_) do
        false
      end
    )
  )
end
