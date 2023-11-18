# credo:disable-for-this-file
defmodule Opentelemetry.Proto.Trace.V1.Status.StatusCode do
  @moduledoc false
  (
    defstruct []

    (
      @spec default() :: :STATUS_CODE_UNSET
      def default() do
        :STATUS_CODE_UNSET
      end
    )

    @spec encode(atom() | String.t()) :: integer() | atom()
    [
      (
        def encode(:STATUS_CODE_UNSET) do
          0
        end

        def encode("STATUS_CODE_UNSET") do
          0
        end
      ),
      (
        def encode(:STATUS_CODE_OK) do
          1
        end

        def encode("STATUS_CODE_OK") do
          1
        end
      ),
      (
        def encode(:STATUS_CODE_ERROR) do
          2
        end

        def encode("STATUS_CODE_ERROR") do
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
        :STATUS_CODE_UNSET
      end,
      def decode(1) do
        :STATUS_CODE_OK
      end,
      def decode(2) do
        :STATUS_CODE_ERROR
      end
    ]

    def decode(x) do
      x
    end

    @spec constants() :: [{integer(), atom()}]
    def constants() do
      [{0, :STATUS_CODE_UNSET}, {1, :STATUS_CODE_OK}, {2, :STATUS_CODE_ERROR}]
    end

    @spec has_constant?(any()) :: boolean()
    (
      [
        def has_constant?(:STATUS_CODE_UNSET) do
          true
        end,
        def has_constant?(:STATUS_CODE_OK) do
          true
        end,
        def has_constant?(:STATUS_CODE_ERROR) do
          true
        end
      ]

      def has_constant?(_) do
        false
      end
    )
  )
end
