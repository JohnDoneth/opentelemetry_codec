# credo:disable-for-this-file
defmodule Opentelemetry.Proto.Metrics.V1.ExponentialHistogramDataPoint do
  @moduledoc false
  defstruct attributes: [],
            start_time_unix_nano: 0,
            time_unix_nano: 0,
            count: 0,
            sum: nil,
            scale: 0,
            zero_count: 0,
            positive: nil,
            negative: nil,
            flags: 0,
            exemplars: [],
            min: nil,
            max: nil,
            zero_threshold: 0.0,
            __uf__: []

  (
    (
      @spec encode(struct) :: {:ok, iodata} | {:error, any}
      def encode(msg) do
        try do
          {:ok, encode!(msg)}
        rescue
          e in [Protox.EncodingError, Protox.RequiredFieldsError] -> {:error, e}
        end
      end

      @spec encode!(struct) :: iodata | no_return
      def encode!(msg) do
        []
        |> encode_sum(msg)
        |> encode_min(msg)
        |> encode_max(msg)
        |> encode_attributes(msg)
        |> encode_start_time_unix_nano(msg)
        |> encode_time_unix_nano(msg)
        |> encode_count(msg)
        |> encode_scale(msg)
        |> encode_zero_count(msg)
        |> encode_positive(msg)
        |> encode_negative(msg)
        |> encode_flags(msg)
        |> encode_exemplars(msg)
        |> encode_zero_threshold(msg)
        |> encode_unknown_fields(msg)
      end
    )

    []

    [
      defp encode_attributes(acc, msg) do
        try do
          case msg.attributes do
            [] ->
              acc

            values ->
              [
                acc,
                Enum.reduce(values, [], fn value, acc ->
                  [acc, "\n", Protox.Encode.encode_message(value)]
                end)
              ]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:attributes, "invalid field value"), __STACKTRACE__
        end
      end,
      defp encode_start_time_unix_nano(acc, msg) do
        try do
          if msg.start_time_unix_nano == 0 do
            acc
          else
            [acc, "\x11", Protox.Encode.encode_fixed64(msg.start_time_unix_nano)]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:start_time_unix_nano, "invalid field value"),
                    __STACKTRACE__
        end
      end,
      defp encode_time_unix_nano(acc, msg) do
        try do
          if msg.time_unix_nano == 0 do
            acc
          else
            [acc, "\x19", Protox.Encode.encode_fixed64(msg.time_unix_nano)]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:time_unix_nano, "invalid field value"),
                    __STACKTRACE__
        end
      end,
      defp encode_count(acc, msg) do
        try do
          if msg.count == 0 do
            acc
          else
            [acc, "!", Protox.Encode.encode_fixed64(msg.count)]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:count, "invalid field value"), __STACKTRACE__
        end
      end,
      defp encode_sum(acc, msg) do
        try do
          case msg.sum do
            nil -> [acc]
            child_field_value -> [acc, ")", Protox.Encode.encode_double(child_field_value)]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:sum, "invalid field value"), __STACKTRACE__
        end
      end,
      defp encode_scale(acc, msg) do
        try do
          if msg.scale == 0 do
            acc
          else
            [acc, "0", Protox.Encode.encode_sint32(msg.scale)]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:scale, "invalid field value"), __STACKTRACE__
        end
      end,
      defp encode_zero_count(acc, msg) do
        try do
          if msg.zero_count == 0 do
            acc
          else
            [acc, "9", Protox.Encode.encode_fixed64(msg.zero_count)]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:zero_count, "invalid field value"), __STACKTRACE__
        end
      end,
      defp encode_positive(acc, msg) do
        try do
          if msg.positive == nil do
            acc
          else
            [acc, "B", Protox.Encode.encode_message(msg.positive)]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:positive, "invalid field value"), __STACKTRACE__
        end
      end,
      defp encode_negative(acc, msg) do
        try do
          if msg.negative == nil do
            acc
          else
            [acc, "J", Protox.Encode.encode_message(msg.negative)]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:negative, "invalid field value"), __STACKTRACE__
        end
      end,
      defp encode_flags(acc, msg) do
        try do
          if msg.flags == 0 do
            acc
          else
            [acc, "P", Protox.Encode.encode_uint32(msg.flags)]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:flags, "invalid field value"), __STACKTRACE__
        end
      end,
      defp encode_exemplars(acc, msg) do
        try do
          case msg.exemplars do
            [] ->
              acc

            values ->
              [
                acc,
                Enum.reduce(values, [], fn value, acc ->
                  [acc, "Z", Protox.Encode.encode_message(value)]
                end)
              ]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:exemplars, "invalid field value"), __STACKTRACE__
        end
      end,
      defp encode_min(acc, msg) do
        try do
          case msg.min do
            nil -> [acc]
            child_field_value -> [acc, "a", Protox.Encode.encode_double(child_field_value)]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:min, "invalid field value"), __STACKTRACE__
        end
      end,
      defp encode_max(acc, msg) do
        try do
          case msg.max do
            nil -> [acc]
            child_field_value -> [acc, "i", Protox.Encode.encode_double(child_field_value)]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:max, "invalid field value"), __STACKTRACE__
        end
      end,
      defp encode_zero_threshold(acc, msg) do
        try do
          if msg.zero_threshold == 0.0 do
            acc
          else
            [acc, "q", Protox.Encode.encode_double(msg.zero_threshold)]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:zero_threshold, "invalid field value"),
                    __STACKTRACE__
        end
      end
    ]

    defp encode_unknown_fields(acc, msg) do
      Enum.reduce(msg.__struct__.unknown_fields(msg), acc, fn {tag, wire_type, bytes}, acc ->
        case wire_type do
          0 ->
            [acc, Protox.Encode.make_key_bytes(tag, :int32), bytes]

          1 ->
            [acc, Protox.Encode.make_key_bytes(tag, :double), bytes]

          2 ->
            len_bytes = bytes |> byte_size() |> Protox.Varint.encode()
            [acc, Protox.Encode.make_key_bytes(tag, :packed), len_bytes, bytes]

          5 ->
            [acc, Protox.Encode.make_key_bytes(tag, :float), bytes]
        end
      end)
    end
  )

  (
    (
      @spec decode(binary) :: {:ok, struct} | {:error, any}
      def decode(bytes) do
        try do
          {:ok, decode!(bytes)}
        rescue
          e in [Protox.DecodingError, Protox.IllegalTagError, Protox.RequiredFieldsError] ->
            {:error, e}
        end
      end

      (
        @spec decode!(binary) :: struct | no_return
        def decode!(bytes) do
          parse_key_value(
            bytes,
            struct(Opentelemetry.Proto.Metrics.V1.ExponentialHistogramDataPoint)
          )
        end
      )
    )

    (
      @spec parse_key_value(binary, struct) :: struct
      defp parse_key_value(<<>>, msg) do
        msg
      end

      defp parse_key_value(bytes, msg) do
        {field, rest} =
          case Protox.Decode.parse_key(bytes) do
            {0, _, _} ->
              raise %Protox.IllegalTagError{}

            {1, _, bytes} ->
              {len, bytes} = Protox.Varint.decode(bytes)
              {delimited, rest} = Protox.Decode.parse_delimited(bytes, len)

              {[
                 attributes:
                   msg.attributes ++ [Opentelemetry.Proto.Common.V1.KeyValue.decode!(delimited)]
               ], rest}

            {2, _, bytes} ->
              {value, rest} = Protox.Decode.parse_fixed64(bytes)
              {[start_time_unix_nano: value], rest}

            {3, _, bytes} ->
              {value, rest} = Protox.Decode.parse_fixed64(bytes)
              {[time_unix_nano: value], rest}

            {4, _, bytes} ->
              {value, rest} = Protox.Decode.parse_fixed64(bytes)
              {[count: value], rest}

            {5, _, bytes} ->
              {value, rest} = Protox.Decode.parse_double(bytes)
              {[sum: value], rest}

            {6, _, bytes} ->
              {value, rest} = Protox.Decode.parse_sint32(bytes)
              {[scale: value], rest}

            {7, _, bytes} ->
              {value, rest} = Protox.Decode.parse_fixed64(bytes)
              {[zero_count: value], rest}

            {8, _, bytes} ->
              {len, bytes} = Protox.Varint.decode(bytes)
              {delimited, rest} = Protox.Decode.parse_delimited(bytes, len)

              {[
                 positive:
                   Protox.MergeMessage.merge(
                     msg.positive,
                     Opentelemetry.Proto.Metrics.V1.ExponentialHistogramDataPoint.Buckets.decode!(
                       delimited
                     )
                   )
               ], rest}

            {9, _, bytes} ->
              {len, bytes} = Protox.Varint.decode(bytes)
              {delimited, rest} = Protox.Decode.parse_delimited(bytes, len)

              {[
                 negative:
                   Protox.MergeMessage.merge(
                     msg.negative,
                     Opentelemetry.Proto.Metrics.V1.ExponentialHistogramDataPoint.Buckets.decode!(
                       delimited
                     )
                   )
               ], rest}

            {10, _, bytes} ->
              {value, rest} = Protox.Decode.parse_uint32(bytes)
              {[flags: value], rest}

            {11, _, bytes} ->
              {len, bytes} = Protox.Varint.decode(bytes)
              {delimited, rest} = Protox.Decode.parse_delimited(bytes, len)

              {[
                 exemplars:
                   msg.exemplars ++ [Opentelemetry.Proto.Metrics.V1.Exemplar.decode!(delimited)]
               ], rest}

            {12, _, bytes} ->
              {value, rest} = Protox.Decode.parse_double(bytes)
              {[min: value], rest}

            {13, _, bytes} ->
              {value, rest} = Protox.Decode.parse_double(bytes)
              {[max: value], rest}

            {14, _, bytes} ->
              {value, rest} = Protox.Decode.parse_double(bytes)
              {[zero_threshold: value], rest}

            {tag, wire_type, rest} ->
              {value, rest} = Protox.Decode.parse_unknown(tag, wire_type, rest)

              {[
                 {msg.__struct__.unknown_fields_name,
                  [value | msg.__struct__.unknown_fields(msg)]}
               ], rest}
          end

        msg_updated = struct(msg, field)
        parse_key_value(rest, msg_updated)
      end
    )

    []
  )

  (
    @spec json_decode(iodata(), keyword()) :: {:ok, struct()} | {:error, any()}
    def json_decode(input, opts \\ []) do
      try do
        {:ok, json_decode!(input, opts)}
      rescue
        e in Protox.JsonDecodingError -> {:error, e}
      end
    end

    @spec json_decode!(iodata(), keyword()) :: struct() | no_return()
    def json_decode!(input, opts \\ []) do
      {json_library_wrapper, json_library} = Protox.JsonLibrary.get_library(opts, :decode)

      Protox.JsonDecode.decode!(
        input,
        Opentelemetry.Proto.Metrics.V1.ExponentialHistogramDataPoint,
        &json_library_wrapper.decode!(json_library, &1)
      )
    end

    @spec json_encode(struct(), keyword()) :: {:ok, iodata()} | {:error, any()}
    def json_encode(msg, opts \\ []) do
      try do
        {:ok, json_encode!(msg, opts)}
      rescue
        e in Protox.JsonEncodingError -> {:error, e}
      end
    end

    @spec json_encode!(struct(), keyword()) :: iodata() | no_return()
    def json_encode!(msg, opts \\ []) do
      {json_library_wrapper, json_library} = Protox.JsonLibrary.get_library(opts, :encode)
      Protox.JsonEncode.encode!(msg, &json_library_wrapper.encode!(json_library, &1))
    end
  )

  (
    @deprecated "Use fields_defs()/0 instead"
    @spec defs() :: %{
            required(non_neg_integer) => {atom, Protox.Types.kind(), Protox.Types.type()}
          }
    def defs() do
      %{
        1 => {:attributes, :unpacked, {:message, Opentelemetry.Proto.Common.V1.KeyValue}},
        2 => {:start_time_unix_nano, {:scalar, 0}, :fixed64},
        3 => {:time_unix_nano, {:scalar, 0}, :fixed64},
        4 => {:count, {:scalar, 0}, :fixed64},
        5 => {:sum, {:oneof, :_sum}, :double},
        6 => {:scale, {:scalar, 0}, :sint32},
        7 => {:zero_count, {:scalar, 0}, :fixed64},
        8 =>
          {:positive, {:scalar, nil},
           {:message, Opentelemetry.Proto.Metrics.V1.ExponentialHistogramDataPoint.Buckets}},
        9 =>
          {:negative, {:scalar, nil},
           {:message, Opentelemetry.Proto.Metrics.V1.ExponentialHistogramDataPoint.Buckets}},
        10 => {:flags, {:scalar, 0}, :uint32},
        11 => {:exemplars, :unpacked, {:message, Opentelemetry.Proto.Metrics.V1.Exemplar}},
        12 => {:min, {:oneof, :_min}, :double},
        13 => {:max, {:oneof, :_max}, :double},
        14 => {:zero_threshold, {:scalar, 0.0}, :double}
      }
    end

    @deprecated "Use fields_defs()/0 instead"
    @spec defs_by_name() :: %{
            required(atom) => {non_neg_integer, Protox.Types.kind(), Protox.Types.type()}
          }
    def defs_by_name() do
      %{
        attributes: {1, :unpacked, {:message, Opentelemetry.Proto.Common.V1.KeyValue}},
        count: {4, {:scalar, 0}, :fixed64},
        exemplars: {11, :unpacked, {:message, Opentelemetry.Proto.Metrics.V1.Exemplar}},
        flags: {10, {:scalar, 0}, :uint32},
        max: {13, {:oneof, :_max}, :double},
        min: {12, {:oneof, :_min}, :double},
        negative:
          {9, {:scalar, nil},
           {:message, Opentelemetry.Proto.Metrics.V1.ExponentialHistogramDataPoint.Buckets}},
        positive:
          {8, {:scalar, nil},
           {:message, Opentelemetry.Proto.Metrics.V1.ExponentialHistogramDataPoint.Buckets}},
        scale: {6, {:scalar, 0}, :sint32},
        start_time_unix_nano: {2, {:scalar, 0}, :fixed64},
        sum: {5, {:oneof, :_sum}, :double},
        time_unix_nano: {3, {:scalar, 0}, :fixed64},
        zero_count: {7, {:scalar, 0}, :fixed64},
        zero_threshold: {14, {:scalar, 0.0}, :double}
      }
    end
  )

  (
    @spec fields_defs() :: list(Protox.Field.t())
    def fields_defs() do
      [
        %{
          __struct__: Protox.Field,
          json_name: "attributes",
          kind: :unpacked,
          label: :repeated,
          name: :attributes,
          tag: 1,
          type: {:message, Opentelemetry.Proto.Common.V1.KeyValue}
        },
        %{
          __struct__: Protox.Field,
          json_name: "startTimeUnixNano",
          kind: {:scalar, 0},
          label: :optional,
          name: :start_time_unix_nano,
          tag: 2,
          type: :fixed64
        },
        %{
          __struct__: Protox.Field,
          json_name: "timeUnixNano",
          kind: {:scalar, 0},
          label: :optional,
          name: :time_unix_nano,
          tag: 3,
          type: :fixed64
        },
        %{
          __struct__: Protox.Field,
          json_name: "count",
          kind: {:scalar, 0},
          label: :optional,
          name: :count,
          tag: 4,
          type: :fixed64
        },
        %{
          __struct__: Protox.Field,
          json_name: "sum",
          kind: {:oneof, :_sum},
          label: :proto3_optional,
          name: :sum,
          tag: 5,
          type: :double
        },
        %{
          __struct__: Protox.Field,
          json_name: "scale",
          kind: {:scalar, 0},
          label: :optional,
          name: :scale,
          tag: 6,
          type: :sint32
        },
        %{
          __struct__: Protox.Field,
          json_name: "zeroCount",
          kind: {:scalar, 0},
          label: :optional,
          name: :zero_count,
          tag: 7,
          type: :fixed64
        },
        %{
          __struct__: Protox.Field,
          json_name: "positive",
          kind: {:scalar, nil},
          label: :optional,
          name: :positive,
          tag: 8,
          type: {:message, Opentelemetry.Proto.Metrics.V1.ExponentialHistogramDataPoint.Buckets}
        },
        %{
          __struct__: Protox.Field,
          json_name: "negative",
          kind: {:scalar, nil},
          label: :optional,
          name: :negative,
          tag: 9,
          type: {:message, Opentelemetry.Proto.Metrics.V1.ExponentialHistogramDataPoint.Buckets}
        },
        %{
          __struct__: Protox.Field,
          json_name: "flags",
          kind: {:scalar, 0},
          label: :optional,
          name: :flags,
          tag: 10,
          type: :uint32
        },
        %{
          __struct__: Protox.Field,
          json_name: "exemplars",
          kind: :unpacked,
          label: :repeated,
          name: :exemplars,
          tag: 11,
          type: {:message, Opentelemetry.Proto.Metrics.V1.Exemplar}
        },
        %{
          __struct__: Protox.Field,
          json_name: "min",
          kind: {:oneof, :_min},
          label: :proto3_optional,
          name: :min,
          tag: 12,
          type: :double
        },
        %{
          __struct__: Protox.Field,
          json_name: "max",
          kind: {:oneof, :_max},
          label: :proto3_optional,
          name: :max,
          tag: 13,
          type: :double
        },
        %{
          __struct__: Protox.Field,
          json_name: "zeroThreshold",
          kind: {:scalar, 0.0},
          label: :optional,
          name: :zero_threshold,
          tag: 14,
          type: :double
        }
      ]
    end

    [
      @spec(field_def(atom) :: {:ok, Protox.Field.t()} | {:error, :no_such_field}),
      (
        def field_def(:attributes) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "attributes",
             kind: :unpacked,
             label: :repeated,
             name: :attributes,
             tag: 1,
             type: {:message, Opentelemetry.Proto.Common.V1.KeyValue}
           }}
        end

        def field_def("attributes") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "attributes",
             kind: :unpacked,
             label: :repeated,
             name: :attributes,
             tag: 1,
             type: {:message, Opentelemetry.Proto.Common.V1.KeyValue}
           }}
        end

        []
      ),
      (
        def field_def(:start_time_unix_nano) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "startTimeUnixNano",
             kind: {:scalar, 0},
             label: :optional,
             name: :start_time_unix_nano,
             tag: 2,
             type: :fixed64
           }}
        end

        def field_def("startTimeUnixNano") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "startTimeUnixNano",
             kind: {:scalar, 0},
             label: :optional,
             name: :start_time_unix_nano,
             tag: 2,
             type: :fixed64
           }}
        end

        def field_def("start_time_unix_nano") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "startTimeUnixNano",
             kind: {:scalar, 0},
             label: :optional,
             name: :start_time_unix_nano,
             tag: 2,
             type: :fixed64
           }}
        end
      ),
      (
        def field_def(:time_unix_nano) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "timeUnixNano",
             kind: {:scalar, 0},
             label: :optional,
             name: :time_unix_nano,
             tag: 3,
             type: :fixed64
           }}
        end

        def field_def("timeUnixNano") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "timeUnixNano",
             kind: {:scalar, 0},
             label: :optional,
             name: :time_unix_nano,
             tag: 3,
             type: :fixed64
           }}
        end

        def field_def("time_unix_nano") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "timeUnixNano",
             kind: {:scalar, 0},
             label: :optional,
             name: :time_unix_nano,
             tag: 3,
             type: :fixed64
           }}
        end
      ),
      (
        def field_def(:count) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "count",
             kind: {:scalar, 0},
             label: :optional,
             name: :count,
             tag: 4,
             type: :fixed64
           }}
        end

        def field_def("count") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "count",
             kind: {:scalar, 0},
             label: :optional,
             name: :count,
             tag: 4,
             type: :fixed64
           }}
        end

        []
      ),
      (
        def field_def(:sum) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "sum",
             kind: {:oneof, :_sum},
             label: :proto3_optional,
             name: :sum,
             tag: 5,
             type: :double
           }}
        end

        def field_def("sum") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "sum",
             kind: {:oneof, :_sum},
             label: :proto3_optional,
             name: :sum,
             tag: 5,
             type: :double
           }}
        end

        []
      ),
      (
        def field_def(:scale) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "scale",
             kind: {:scalar, 0},
             label: :optional,
             name: :scale,
             tag: 6,
             type: :sint32
           }}
        end

        def field_def("scale") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "scale",
             kind: {:scalar, 0},
             label: :optional,
             name: :scale,
             tag: 6,
             type: :sint32
           }}
        end

        []
      ),
      (
        def field_def(:zero_count) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "zeroCount",
             kind: {:scalar, 0},
             label: :optional,
             name: :zero_count,
             tag: 7,
             type: :fixed64
           }}
        end

        def field_def("zeroCount") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "zeroCount",
             kind: {:scalar, 0},
             label: :optional,
             name: :zero_count,
             tag: 7,
             type: :fixed64
           }}
        end

        def field_def("zero_count") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "zeroCount",
             kind: {:scalar, 0},
             label: :optional,
             name: :zero_count,
             tag: 7,
             type: :fixed64
           }}
        end
      ),
      (
        def field_def(:positive) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "positive",
             kind: {:scalar, nil},
             label: :optional,
             name: :positive,
             tag: 8,
             type:
               {:message, Opentelemetry.Proto.Metrics.V1.ExponentialHistogramDataPoint.Buckets}
           }}
        end

        def field_def("positive") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "positive",
             kind: {:scalar, nil},
             label: :optional,
             name: :positive,
             tag: 8,
             type:
               {:message, Opentelemetry.Proto.Metrics.V1.ExponentialHistogramDataPoint.Buckets}
           }}
        end

        []
      ),
      (
        def field_def(:negative) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "negative",
             kind: {:scalar, nil},
             label: :optional,
             name: :negative,
             tag: 9,
             type:
               {:message, Opentelemetry.Proto.Metrics.V1.ExponentialHistogramDataPoint.Buckets}
           }}
        end

        def field_def("negative") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "negative",
             kind: {:scalar, nil},
             label: :optional,
             name: :negative,
             tag: 9,
             type:
               {:message, Opentelemetry.Proto.Metrics.V1.ExponentialHistogramDataPoint.Buckets}
           }}
        end

        []
      ),
      (
        def field_def(:flags) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "flags",
             kind: {:scalar, 0},
             label: :optional,
             name: :flags,
             tag: 10,
             type: :uint32
           }}
        end

        def field_def("flags") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "flags",
             kind: {:scalar, 0},
             label: :optional,
             name: :flags,
             tag: 10,
             type: :uint32
           }}
        end

        []
      ),
      (
        def field_def(:exemplars) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "exemplars",
             kind: :unpacked,
             label: :repeated,
             name: :exemplars,
             tag: 11,
             type: {:message, Opentelemetry.Proto.Metrics.V1.Exemplar}
           }}
        end

        def field_def("exemplars") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "exemplars",
             kind: :unpacked,
             label: :repeated,
             name: :exemplars,
             tag: 11,
             type: {:message, Opentelemetry.Proto.Metrics.V1.Exemplar}
           }}
        end

        []
      ),
      (
        def field_def(:min) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "min",
             kind: {:oneof, :_min},
             label: :proto3_optional,
             name: :min,
             tag: 12,
             type: :double
           }}
        end

        def field_def("min") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "min",
             kind: {:oneof, :_min},
             label: :proto3_optional,
             name: :min,
             tag: 12,
             type: :double
           }}
        end

        []
      ),
      (
        def field_def(:max) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "max",
             kind: {:oneof, :_max},
             label: :proto3_optional,
             name: :max,
             tag: 13,
             type: :double
           }}
        end

        def field_def("max") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "max",
             kind: {:oneof, :_max},
             label: :proto3_optional,
             name: :max,
             tag: 13,
             type: :double
           }}
        end

        []
      ),
      (
        def field_def(:zero_threshold) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "zeroThreshold",
             kind: {:scalar, 0.0},
             label: :optional,
             name: :zero_threshold,
             tag: 14,
             type: :double
           }}
        end

        def field_def("zeroThreshold") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "zeroThreshold",
             kind: {:scalar, 0.0},
             label: :optional,
             name: :zero_threshold,
             tag: 14,
             type: :double
           }}
        end

        def field_def("zero_threshold") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "zeroThreshold",
             kind: {:scalar, 0.0},
             label: :optional,
             name: :zero_threshold,
             tag: 14,
             type: :double
           }}
        end
      ),
      def field_def(_) do
        {:error, :no_such_field}
      end
    ]
  )

  (
    @spec unknown_fields(struct) :: [{non_neg_integer, Protox.Types.tag(), binary}]
    def unknown_fields(msg) do
      msg.__uf__
    end

    @spec unknown_fields_name() :: :__uf__
    def unknown_fields_name() do
      :__uf__
    end

    @spec clear_unknown_fields(struct) :: struct
    def clear_unknown_fields(msg) do
      struct!(msg, [{unknown_fields_name(), []}])
    end
  )

  (
    @spec required_fields() :: []
    def required_fields() do
      []
    end
  )

  (
    @spec syntax() :: atom()
    def syntax() do
      :proto3
    end
  )

  [
    @spec(default(atom) :: {:ok, boolean | integer | String.t() | float} | {:error, atom}),
    def default(:attributes) do
      {:error, :no_default_value}
    end,
    def default(:start_time_unix_nano) do
      {:ok, 0}
    end,
    def default(:time_unix_nano) do
      {:ok, 0}
    end,
    def default(:count) do
      {:ok, 0}
    end,
    def default(:sum) do
      {:error, :no_default_value}
    end,
    def default(:scale) do
      {:ok, 0}
    end,
    def default(:zero_count) do
      {:ok, 0}
    end,
    def default(:positive) do
      {:ok, nil}
    end,
    def default(:negative) do
      {:ok, nil}
    end,
    def default(:flags) do
      {:ok, 0}
    end,
    def default(:exemplars) do
      {:error, :no_default_value}
    end,
    def default(:min) do
      {:error, :no_default_value}
    end,
    def default(:max) do
      {:error, :no_default_value}
    end,
    def default(:zero_threshold) do
      {:ok, 0.0}
    end,
    def default(_) do
      {:error, :no_such_field}
    end
  ]

  (
    @spec file_options() :: struct()
    def file_options() do
      file_options = %{
        __struct__: Protox.Google.Protobuf.FileOptions,
        __uf__: [],
        cc_enable_arenas: nil,
        cc_generic_services: nil,
        csharp_namespace: "OpenTelemetry.Proto.Metrics.V1",
        deprecated: nil,
        go_package: "go.opentelemetry.io/proto/otlp/metrics/v1",
        java_generate_equals_and_hash: nil,
        java_generic_services: nil,
        java_multiple_files: true,
        java_outer_classname: "MetricsProto",
        java_package: "io.opentelemetry.proto.metrics.v1",
        java_string_check_utf8: nil,
        objc_class_prefix: nil,
        optimize_for: nil,
        php_class_prefix: nil,
        php_generic_services: nil,
        php_metadata_namespace: nil,
        php_namespace: nil,
        py_generic_services: nil,
        ruby_package: nil,
        swift_prefix: nil,
        uninterpreted_option: []
      }

      case function_exported?(Google.Protobuf.FileOptions, :decode!, 1) do
        true ->
          bytes =
            file_options |> Protox.Google.Protobuf.FileOptions.encode!() |> :binary.list_to_bin()

          apply(Google.Protobuf.FileOptions, :decode!, [bytes])

        false ->
          file_options
      end
    end
  )
end
