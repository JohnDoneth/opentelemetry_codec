# credo:disable-for-this-file
defmodule Opentelemetry.Proto.Metrics.V1.SummaryDataPoint do
  @moduledoc false
  defstruct start_time_unix_nano: 0,
            time_unix_nano: 0,
            count: 0,
            sum: 0.0,
            quantile_values: [],
            attributes: [],
            flags: 0,
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
        |> encode_start_time_unix_nano(msg)
        |> encode_time_unix_nano(msg)
        |> encode_count(msg)
        |> encode_sum(msg)
        |> encode_quantile_values(msg)
        |> encode_attributes(msg)
        |> encode_flags(msg)
        |> encode_unknown_fields(msg)
      end
    )

    []

    [
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
          if msg.sum == 0.0 do
            acc
          else
            [acc, ")", Protox.Encode.encode_double(msg.sum)]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:sum, "invalid field value"), __STACKTRACE__
        end
      end,
      defp encode_quantile_values(acc, msg) do
        try do
          case msg.quantile_values do
            [] ->
              acc

            values ->
              [
                acc,
                Enum.reduce(values, [], fn value, acc ->
                  [acc, "2", Protox.Encode.encode_message(value)]
                end)
              ]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:quantile_values, "invalid field value"),
                    __STACKTRACE__
        end
      end,
      defp encode_attributes(acc, msg) do
        try do
          case msg.attributes do
            [] ->
              acc

            values ->
              [
                acc,
                Enum.reduce(values, [], fn value, acc ->
                  [acc, ":", Protox.Encode.encode_message(value)]
                end)
              ]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:attributes, "invalid field value"), __STACKTRACE__
        end
      end,
      defp encode_flags(acc, msg) do
        try do
          if msg.flags == 0 do
            acc
          else
            [acc, "@", Protox.Encode.encode_uint32(msg.flags)]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:flags, "invalid field value"), __STACKTRACE__
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
          parse_key_value(bytes, struct(Opentelemetry.Proto.Metrics.V1.SummaryDataPoint))
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
              {len, bytes} = Protox.Varint.decode(bytes)
              {delimited, rest} = Protox.Decode.parse_delimited(bytes, len)

              {[
                 quantile_values:
                   msg.quantile_values ++
                     [
                       Opentelemetry.Proto.Metrics.V1.SummaryDataPoint.ValueAtQuantile.decode!(
                         delimited
                       )
                     ]
               ], rest}

            {7, _, bytes} ->
              {len, bytes} = Protox.Varint.decode(bytes)
              {delimited, rest} = Protox.Decode.parse_delimited(bytes, len)

              {[
                 attributes:
                   msg.attributes ++ [Opentelemetry.Proto.Common.V1.KeyValue.decode!(delimited)]
               ], rest}

            {8, _, bytes} ->
              {value, rest} = Protox.Decode.parse_uint32(bytes)
              {[flags: value], rest}

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
        Opentelemetry.Proto.Metrics.V1.SummaryDataPoint,
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
        2 => {:start_time_unix_nano, {:scalar, 0}, :fixed64},
        3 => {:time_unix_nano, {:scalar, 0}, :fixed64},
        4 => {:count, {:scalar, 0}, :fixed64},
        5 => {:sum, {:scalar, 0.0}, :double},
        6 =>
          {:quantile_values, :unpacked,
           {:message, Opentelemetry.Proto.Metrics.V1.SummaryDataPoint.ValueAtQuantile}},
        7 => {:attributes, :unpacked, {:message, Opentelemetry.Proto.Common.V1.KeyValue}},
        8 => {:flags, {:scalar, 0}, :uint32}
      }
    end

    @deprecated "Use fields_defs()/0 instead"
    @spec defs_by_name() :: %{
            required(atom) => {non_neg_integer, Protox.Types.kind(), Protox.Types.type()}
          }
    def defs_by_name() do
      %{
        attributes: {7, :unpacked, {:message, Opentelemetry.Proto.Common.V1.KeyValue}},
        count: {4, {:scalar, 0}, :fixed64},
        flags: {8, {:scalar, 0}, :uint32},
        quantile_values:
          {6, :unpacked,
           {:message, Opentelemetry.Proto.Metrics.V1.SummaryDataPoint.ValueAtQuantile}},
        start_time_unix_nano: {2, {:scalar, 0}, :fixed64},
        sum: {5, {:scalar, 0.0}, :double},
        time_unix_nano: {3, {:scalar, 0}, :fixed64}
      }
    end
  )

  (
    @spec fields_defs() :: list(Protox.Field.t())
    def fields_defs() do
      [
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
          kind: {:scalar, 0.0},
          label: :optional,
          name: :sum,
          tag: 5,
          type: :double
        },
        %{
          __struct__: Protox.Field,
          json_name: "quantileValues",
          kind: :unpacked,
          label: :repeated,
          name: :quantile_values,
          tag: 6,
          type: {:message, Opentelemetry.Proto.Metrics.V1.SummaryDataPoint.ValueAtQuantile}
        },
        %{
          __struct__: Protox.Field,
          json_name: "attributes",
          kind: :unpacked,
          label: :repeated,
          name: :attributes,
          tag: 7,
          type: {:message, Opentelemetry.Proto.Common.V1.KeyValue}
        },
        %{
          __struct__: Protox.Field,
          json_name: "flags",
          kind: {:scalar, 0},
          label: :optional,
          name: :flags,
          tag: 8,
          type: :uint32
        }
      ]
    end

    [
      @spec(field_def(atom) :: {:ok, Protox.Field.t()} | {:error, :no_such_field}),
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
             kind: {:scalar, 0.0},
             label: :optional,
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
             kind: {:scalar, 0.0},
             label: :optional,
             name: :sum,
             tag: 5,
             type: :double
           }}
        end

        []
      ),
      (
        def field_def(:quantile_values) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "quantileValues",
             kind: :unpacked,
             label: :repeated,
             name: :quantile_values,
             tag: 6,
             type: {:message, Opentelemetry.Proto.Metrics.V1.SummaryDataPoint.ValueAtQuantile}
           }}
        end

        def field_def("quantileValues") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "quantileValues",
             kind: :unpacked,
             label: :repeated,
             name: :quantile_values,
             tag: 6,
             type: {:message, Opentelemetry.Proto.Metrics.V1.SummaryDataPoint.ValueAtQuantile}
           }}
        end

        def field_def("quantile_values") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "quantileValues",
             kind: :unpacked,
             label: :repeated,
             name: :quantile_values,
             tag: 6,
             type: {:message, Opentelemetry.Proto.Metrics.V1.SummaryDataPoint.ValueAtQuantile}
           }}
        end
      ),
      (
        def field_def(:attributes) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "attributes",
             kind: :unpacked,
             label: :repeated,
             name: :attributes,
             tag: 7,
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
             tag: 7,
             type: {:message, Opentelemetry.Proto.Common.V1.KeyValue}
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
             tag: 8,
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
             tag: 8,
             type: :uint32
           }}
        end

        []
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
      {:ok, 0.0}
    end,
    def default(:quantile_values) do
      {:error, :no_default_value}
    end,
    def default(:attributes) do
      {:error, :no_default_value}
    end,
    def default(:flags) do
      {:ok, 0}
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
