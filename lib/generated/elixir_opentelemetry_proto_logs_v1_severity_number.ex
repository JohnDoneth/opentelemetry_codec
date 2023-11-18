# credo:disable-for-this-file
defmodule Opentelemetry.Proto.Logs.V1.SeverityNumber do
  @moduledoc false
  (
    defstruct []

    (
      @spec default() :: :SEVERITY_NUMBER_UNSPECIFIED
      def default() do
        :SEVERITY_NUMBER_UNSPECIFIED
      end
    )

    @spec encode(atom() | String.t()) :: integer() | atom()
    [
      (
        def encode(:SEVERITY_NUMBER_UNSPECIFIED) do
          0
        end

        def encode("SEVERITY_NUMBER_UNSPECIFIED") do
          0
        end
      ),
      (
        def encode(:SEVERITY_NUMBER_TRACE) do
          1
        end

        def encode("SEVERITY_NUMBER_TRACE") do
          1
        end
      ),
      (
        def encode(:SEVERITY_NUMBER_TRACE2) do
          2
        end

        def encode("SEVERITY_NUMBER_TRACE2") do
          2
        end
      ),
      (
        def encode(:SEVERITY_NUMBER_TRACE3) do
          3
        end

        def encode("SEVERITY_NUMBER_TRACE3") do
          3
        end
      ),
      (
        def encode(:SEVERITY_NUMBER_TRACE4) do
          4
        end

        def encode("SEVERITY_NUMBER_TRACE4") do
          4
        end
      ),
      (
        def encode(:SEVERITY_NUMBER_DEBUG) do
          5
        end

        def encode("SEVERITY_NUMBER_DEBUG") do
          5
        end
      ),
      (
        def encode(:SEVERITY_NUMBER_DEBUG2) do
          6
        end

        def encode("SEVERITY_NUMBER_DEBUG2") do
          6
        end
      ),
      (
        def encode(:SEVERITY_NUMBER_DEBUG3) do
          7
        end

        def encode("SEVERITY_NUMBER_DEBUG3") do
          7
        end
      ),
      (
        def encode(:SEVERITY_NUMBER_DEBUG4) do
          8
        end

        def encode("SEVERITY_NUMBER_DEBUG4") do
          8
        end
      ),
      (
        def encode(:SEVERITY_NUMBER_INFO) do
          9
        end

        def encode("SEVERITY_NUMBER_INFO") do
          9
        end
      ),
      (
        def encode(:SEVERITY_NUMBER_INFO2) do
          10
        end

        def encode("SEVERITY_NUMBER_INFO2") do
          10
        end
      ),
      (
        def encode(:SEVERITY_NUMBER_INFO3) do
          11
        end

        def encode("SEVERITY_NUMBER_INFO3") do
          11
        end
      ),
      (
        def encode(:SEVERITY_NUMBER_INFO4) do
          12
        end

        def encode("SEVERITY_NUMBER_INFO4") do
          12
        end
      ),
      (
        def encode(:SEVERITY_NUMBER_WARN) do
          13
        end

        def encode("SEVERITY_NUMBER_WARN") do
          13
        end
      ),
      (
        def encode(:SEVERITY_NUMBER_WARN2) do
          14
        end

        def encode("SEVERITY_NUMBER_WARN2") do
          14
        end
      ),
      (
        def encode(:SEVERITY_NUMBER_WARN3) do
          15
        end

        def encode("SEVERITY_NUMBER_WARN3") do
          15
        end
      ),
      (
        def encode(:SEVERITY_NUMBER_WARN4) do
          16
        end

        def encode("SEVERITY_NUMBER_WARN4") do
          16
        end
      ),
      (
        def encode(:SEVERITY_NUMBER_ERROR) do
          17
        end

        def encode("SEVERITY_NUMBER_ERROR") do
          17
        end
      ),
      (
        def encode(:SEVERITY_NUMBER_ERROR2) do
          18
        end

        def encode("SEVERITY_NUMBER_ERROR2") do
          18
        end
      ),
      (
        def encode(:SEVERITY_NUMBER_ERROR3) do
          19
        end

        def encode("SEVERITY_NUMBER_ERROR3") do
          19
        end
      ),
      (
        def encode(:SEVERITY_NUMBER_ERROR4) do
          20
        end

        def encode("SEVERITY_NUMBER_ERROR4") do
          20
        end
      ),
      (
        def encode(:SEVERITY_NUMBER_FATAL) do
          21
        end

        def encode("SEVERITY_NUMBER_FATAL") do
          21
        end
      ),
      (
        def encode(:SEVERITY_NUMBER_FATAL2) do
          22
        end

        def encode("SEVERITY_NUMBER_FATAL2") do
          22
        end
      ),
      (
        def encode(:SEVERITY_NUMBER_FATAL3) do
          23
        end

        def encode("SEVERITY_NUMBER_FATAL3") do
          23
        end
      ),
      (
        def encode(:SEVERITY_NUMBER_FATAL4) do
          24
        end

        def encode("SEVERITY_NUMBER_FATAL4") do
          24
        end
      )
    ]

    def encode(x) do
      x
    end

    @spec decode(integer()) :: atom() | integer()
    [
      def decode(0) do
        :SEVERITY_NUMBER_UNSPECIFIED
      end,
      def decode(1) do
        :SEVERITY_NUMBER_TRACE
      end,
      def decode(2) do
        :SEVERITY_NUMBER_TRACE2
      end,
      def decode(3) do
        :SEVERITY_NUMBER_TRACE3
      end,
      def decode(4) do
        :SEVERITY_NUMBER_TRACE4
      end,
      def decode(5) do
        :SEVERITY_NUMBER_DEBUG
      end,
      def decode(6) do
        :SEVERITY_NUMBER_DEBUG2
      end,
      def decode(7) do
        :SEVERITY_NUMBER_DEBUG3
      end,
      def decode(8) do
        :SEVERITY_NUMBER_DEBUG4
      end,
      def decode(9) do
        :SEVERITY_NUMBER_INFO
      end,
      def decode(10) do
        :SEVERITY_NUMBER_INFO2
      end,
      def decode(11) do
        :SEVERITY_NUMBER_INFO3
      end,
      def decode(12) do
        :SEVERITY_NUMBER_INFO4
      end,
      def decode(13) do
        :SEVERITY_NUMBER_WARN
      end,
      def decode(14) do
        :SEVERITY_NUMBER_WARN2
      end,
      def decode(15) do
        :SEVERITY_NUMBER_WARN3
      end,
      def decode(16) do
        :SEVERITY_NUMBER_WARN4
      end,
      def decode(17) do
        :SEVERITY_NUMBER_ERROR
      end,
      def decode(18) do
        :SEVERITY_NUMBER_ERROR2
      end,
      def decode(19) do
        :SEVERITY_NUMBER_ERROR3
      end,
      def decode(20) do
        :SEVERITY_NUMBER_ERROR4
      end,
      def decode(21) do
        :SEVERITY_NUMBER_FATAL
      end,
      def decode(22) do
        :SEVERITY_NUMBER_FATAL2
      end,
      def decode(23) do
        :SEVERITY_NUMBER_FATAL3
      end,
      def decode(24) do
        :SEVERITY_NUMBER_FATAL4
      end
    ]

    def decode(x) do
      x
    end

    @spec constants() :: [{integer(), atom()}]
    def constants() do
      [
        {0, :SEVERITY_NUMBER_UNSPECIFIED},
        {1, :SEVERITY_NUMBER_TRACE},
        {2, :SEVERITY_NUMBER_TRACE2},
        {3, :SEVERITY_NUMBER_TRACE3},
        {4, :SEVERITY_NUMBER_TRACE4},
        {5, :SEVERITY_NUMBER_DEBUG},
        {6, :SEVERITY_NUMBER_DEBUG2},
        {7, :SEVERITY_NUMBER_DEBUG3},
        {8, :SEVERITY_NUMBER_DEBUG4},
        {9, :SEVERITY_NUMBER_INFO},
        {10, :SEVERITY_NUMBER_INFO2},
        {11, :SEVERITY_NUMBER_INFO3},
        {12, :SEVERITY_NUMBER_INFO4},
        {13, :SEVERITY_NUMBER_WARN},
        {14, :SEVERITY_NUMBER_WARN2},
        {15, :SEVERITY_NUMBER_WARN3},
        {16, :SEVERITY_NUMBER_WARN4},
        {17, :SEVERITY_NUMBER_ERROR},
        {18, :SEVERITY_NUMBER_ERROR2},
        {19, :SEVERITY_NUMBER_ERROR3},
        {20, :SEVERITY_NUMBER_ERROR4},
        {21, :SEVERITY_NUMBER_FATAL},
        {22, :SEVERITY_NUMBER_FATAL2},
        {23, :SEVERITY_NUMBER_FATAL3},
        {24, :SEVERITY_NUMBER_FATAL4}
      ]
    end

    @spec has_constant?(any()) :: boolean()
    (
      [
        def has_constant?(:SEVERITY_NUMBER_UNSPECIFIED) do
          true
        end,
        def has_constant?(:SEVERITY_NUMBER_TRACE) do
          true
        end,
        def has_constant?(:SEVERITY_NUMBER_TRACE2) do
          true
        end,
        def has_constant?(:SEVERITY_NUMBER_TRACE3) do
          true
        end,
        def has_constant?(:SEVERITY_NUMBER_TRACE4) do
          true
        end,
        def has_constant?(:SEVERITY_NUMBER_DEBUG) do
          true
        end,
        def has_constant?(:SEVERITY_NUMBER_DEBUG2) do
          true
        end,
        def has_constant?(:SEVERITY_NUMBER_DEBUG3) do
          true
        end,
        def has_constant?(:SEVERITY_NUMBER_DEBUG4) do
          true
        end,
        def has_constant?(:SEVERITY_NUMBER_INFO) do
          true
        end,
        def has_constant?(:SEVERITY_NUMBER_INFO2) do
          true
        end,
        def has_constant?(:SEVERITY_NUMBER_INFO3) do
          true
        end,
        def has_constant?(:SEVERITY_NUMBER_INFO4) do
          true
        end,
        def has_constant?(:SEVERITY_NUMBER_WARN) do
          true
        end,
        def has_constant?(:SEVERITY_NUMBER_WARN2) do
          true
        end,
        def has_constant?(:SEVERITY_NUMBER_WARN3) do
          true
        end,
        def has_constant?(:SEVERITY_NUMBER_WARN4) do
          true
        end,
        def has_constant?(:SEVERITY_NUMBER_ERROR) do
          true
        end,
        def has_constant?(:SEVERITY_NUMBER_ERROR2) do
          true
        end,
        def has_constant?(:SEVERITY_NUMBER_ERROR3) do
          true
        end,
        def has_constant?(:SEVERITY_NUMBER_ERROR4) do
          true
        end,
        def has_constant?(:SEVERITY_NUMBER_FATAL) do
          true
        end,
        def has_constant?(:SEVERITY_NUMBER_FATAL2) do
          true
        end,
        def has_constant?(:SEVERITY_NUMBER_FATAL3) do
          true
        end,
        def has_constant?(:SEVERITY_NUMBER_FATAL4) do
          true
        end
      ]

      def has_constant?(_) do
        false
      end
    )
  )
end
