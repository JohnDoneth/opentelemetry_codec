# credo:disable-for-this-file
defmodule Opentelemetry.Proto.Metrics.V1.Exemplar do
  @moduledoc false
  defstruct time_unix_nano: 0,
            value: nil,
            span_id: "",
            trace_id: "",
            filtered_attributes: [],
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
        |> encode_value(msg)
        |> encode_time_unix_nano(msg)
        |> encode_span_id(msg)
        |> encode_trace_id(msg)
        |> encode_filtered_attributes(msg)
        |> encode_unknown_fields(msg)
      end
    )

    [
      defp encode_value(acc, msg) do
        case msg.value do
          nil -> acc
          {:as_double, _field_value} -> encode_as_double(acc, msg)
          {:as_int, _field_value} -> encode_as_int(acc, msg)
        end
      end
    ]

    [
      defp encode_time_unix_nano(acc, msg) do
        try do
          if msg.time_unix_nano == 0 do
            acc
          else
            [acc, "\x11", Protox.Encode.encode_fixed64(msg.time_unix_nano)]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:time_unix_nano, "invalid field value"),
                    __STACKTRACE__
        end
      end,
      defp encode_as_double(acc, msg) do
        try do
          {_, child_field_value} = msg.value
          [acc, "\x19", Protox.Encode.encode_double(child_field_value)]
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:as_double, "invalid field value"), __STACKTRACE__
        end
      end,
      defp encode_span_id(acc, msg) do
        try do
          if msg.span_id == "" do
            acc
          else
            [acc, "\"", Protox.Encode.encode_bytes(msg.span_id)]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:span_id, "invalid field value"), __STACKTRACE__
        end
      end,
      defp encode_trace_id(acc, msg) do
        try do
          if msg.trace_id == "" do
            acc
          else
            [acc, "*", Protox.Encode.encode_bytes(msg.trace_id)]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:trace_id, "invalid field value"), __STACKTRACE__
        end
      end,
      defp encode_as_int(acc, msg) do
        try do
          {_, child_field_value} = msg.value
          [acc, "1", Protox.Encode.encode_sfixed64(child_field_value)]
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:as_int, "invalid field value"), __STACKTRACE__
        end
      end,
      defp encode_filtered_attributes(acc, msg) do
        try do
          case msg.filtered_attributes do
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
            reraise Protox.EncodingError.new(:filtered_attributes, "invalid field value"),
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
          parse_key_value(bytes, struct(Opentelemetry.Proto.Metrics.V1.Exemplar))
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
              {[time_unix_nano: value], rest}

            {3, _, bytes} ->
              {value, rest} = Protox.Decode.parse_double(bytes)
              {[value: {:as_double, value}], rest}

            {4, _, bytes} ->
              {len, bytes} = Protox.Varint.decode(bytes)
              {delimited, rest} = Protox.Decode.parse_delimited(bytes, len)
              {[span_id: delimited], rest}

            {5, _, bytes} ->
              {len, bytes} = Protox.Varint.decode(bytes)
              {delimited, rest} = Protox.Decode.parse_delimited(bytes, len)
              {[trace_id: delimited], rest}

            {6, _, bytes} ->
              {value, rest} = Protox.Decode.parse_sfixed64(bytes)
              {[value: {:as_int, value}], rest}

            {7, _, bytes} ->
              {len, bytes} = Protox.Varint.decode(bytes)
              {delimited, rest} = Protox.Decode.parse_delimited(bytes, len)

              {[
                 filtered_attributes:
                   msg.filtered_attributes ++
                     [Opentelemetry.Proto.Common.V1.KeyValue.decode!(delimited)]
               ], rest}

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
        Opentelemetry.Proto.Metrics.V1.Exemplar,
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
        2 => {:time_unix_nano, {:scalar, 0}, :fixed64},
        3 => {:as_double, {:oneof, :value}, :double},
        4 => {:span_id, {:scalar, ""}, :bytes},
        5 => {:trace_id, {:scalar, ""}, :bytes},
        6 => {:as_int, {:oneof, :value}, :sfixed64},
        7 => {:filtered_attributes, :unpacked, {:message, Opentelemetry.Proto.Common.V1.KeyValue}}
      }
    end

    @deprecated "Use fields_defs()/0 instead"
    @spec defs_by_name() :: %{
            required(atom) => {non_neg_integer, Protox.Types.kind(), Protox.Types.type()}
          }
    def defs_by_name() do
      %{
        as_double: {3, {:oneof, :value}, :double},
        as_int: {6, {:oneof, :value}, :sfixed64},
        filtered_attributes: {7, :unpacked, {:message, Opentelemetry.Proto.Common.V1.KeyValue}},
        span_id: {4, {:scalar, ""}, :bytes},
        time_unix_nano: {2, {:scalar, 0}, :fixed64},
        trace_id: {5, {:scalar, ""}, :bytes}
      }
    end
  )

  (
    @spec fields_defs() :: list(Protox.Field.t())
    def fields_defs() do
      [
        %{
          __struct__: Protox.Field,
          json_name: "timeUnixNano",
          kind: {:scalar, 0},
          label: :optional,
          name: :time_unix_nano,
          tag: 2,
          type: :fixed64
        },
        %{
          __struct__: Protox.Field,
          json_name: "asDouble",
          kind: {:oneof, :value},
          label: :optional,
          name: :as_double,
          tag: 3,
          type: :double
        },
        %{
          __struct__: Protox.Field,
          json_name: "spanId",
          kind: {:scalar, ""},
          label: :optional,
          name: :span_id,
          tag: 4,
          type: :bytes
        },
        %{
          __struct__: Protox.Field,
          json_name: "traceId",
          kind: {:scalar, ""},
          label: :optional,
          name: :trace_id,
          tag: 5,
          type: :bytes
        },
        %{
          __struct__: Protox.Field,
          json_name: "asInt",
          kind: {:oneof, :value},
          label: :optional,
          name: :as_int,
          tag: 6,
          type: :sfixed64
        },
        %{
          __struct__: Protox.Field,
          json_name: "filteredAttributes",
          kind: :unpacked,
          label: :repeated,
          name: :filtered_attributes,
          tag: 7,
          type: {:message, Opentelemetry.Proto.Common.V1.KeyValue}
        }
      ]
    end

    [
      @spec(field_def(atom) :: {:ok, Protox.Field.t()} | {:error, :no_such_field}),
      (
        def field_def(:time_unix_nano) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "timeUnixNano",
             kind: {:scalar, 0},
             label: :optional,
             name: :time_unix_nano,
             tag: 2,
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
             tag: 2,
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
             tag: 2,
             type: :fixed64
           }}
        end
      ),
      (
        def field_def(:as_double) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "asDouble",
             kind: {:oneof, :value},
             label: :optional,
             name: :as_double,
             tag: 3,
             type: :double
           }}
        end

        def field_def("asDouble") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "asDouble",
             kind: {:oneof, :value},
             label: :optional,
             name: :as_double,
             tag: 3,
             type: :double
           }}
        end

        def field_def("as_double") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "asDouble",
             kind: {:oneof, :value},
             label: :optional,
             name: :as_double,
             tag: 3,
             type: :double
           }}
        end
      ),
      (
        def field_def(:span_id) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "spanId",
             kind: {:scalar, ""},
             label: :optional,
             name: :span_id,
             tag: 4,
             type: :bytes
           }}
        end

        def field_def("spanId") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "spanId",
             kind: {:scalar, ""},
             label: :optional,
             name: :span_id,
             tag: 4,
             type: :bytes
           }}
        end

        def field_def("span_id") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "spanId",
             kind: {:scalar, ""},
             label: :optional,
             name: :span_id,
             tag: 4,
             type: :bytes
           }}
        end
      ),
      (
        def field_def(:trace_id) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "traceId",
             kind: {:scalar, ""},
             label: :optional,
             name: :trace_id,
             tag: 5,
             type: :bytes
           }}
        end

        def field_def("traceId") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "traceId",
             kind: {:scalar, ""},
             label: :optional,
             name: :trace_id,
             tag: 5,
             type: :bytes
           }}
        end

        def field_def("trace_id") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "traceId",
             kind: {:scalar, ""},
             label: :optional,
             name: :trace_id,
             tag: 5,
             type: :bytes
           }}
        end
      ),
      (
        def field_def(:as_int) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "asInt",
             kind: {:oneof, :value},
             label: :optional,
             name: :as_int,
             tag: 6,
             type: :sfixed64
           }}
        end

        def field_def("asInt") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "asInt",
             kind: {:oneof, :value},
             label: :optional,
             name: :as_int,
             tag: 6,
             type: :sfixed64
           }}
        end

        def field_def("as_int") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "asInt",
             kind: {:oneof, :value},
             label: :optional,
             name: :as_int,
             tag: 6,
             type: :sfixed64
           }}
        end
      ),
      (
        def field_def(:filtered_attributes) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "filteredAttributes",
             kind: :unpacked,
             label: :repeated,
             name: :filtered_attributes,
             tag: 7,
             type: {:message, Opentelemetry.Proto.Common.V1.KeyValue}
           }}
        end

        def field_def("filteredAttributes") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "filteredAttributes",
             kind: :unpacked,
             label: :repeated,
             name: :filtered_attributes,
             tag: 7,
             type: {:message, Opentelemetry.Proto.Common.V1.KeyValue}
           }}
        end

        def field_def("filtered_attributes") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "filteredAttributes",
             kind: :unpacked,
             label: :repeated,
             name: :filtered_attributes,
             tag: 7,
             type: {:message, Opentelemetry.Proto.Common.V1.KeyValue}
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
    def default(:time_unix_nano) do
      {:ok, 0}
    end,
    def default(:as_double) do
      {:error, :no_default_value}
    end,
    def default(:span_id) do
      {:ok, ""}
    end,
    def default(:trace_id) do
      {:ok, ""}
    end,
    def default(:as_int) do
      {:error, :no_default_value}
    end,
    def default(:filtered_attributes) do
      {:error, :no_default_value}
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
