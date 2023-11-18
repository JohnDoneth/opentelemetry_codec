# credo:disable-for-this-file
defmodule Opentelemetry.Proto.Logs.V1.LogRecord do
  @moduledoc false
  defstruct time_unix_nano: 0,
            severity_number: :SEVERITY_NUMBER_UNSPECIFIED,
            severity_text: "",
            body: nil,
            attributes: [],
            dropped_attributes_count: 0,
            flags: 0,
            trace_id: "",
            span_id: "",
            observed_time_unix_nano: 0,
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
        |> encode_time_unix_nano(msg)
        |> encode_severity_number(msg)
        |> encode_severity_text(msg)
        |> encode_body(msg)
        |> encode_attributes(msg)
        |> encode_dropped_attributes_count(msg)
        |> encode_flags(msg)
        |> encode_trace_id(msg)
        |> encode_span_id(msg)
        |> encode_observed_time_unix_nano(msg)
        |> encode_unknown_fields(msg)
      end
    )

    []

    [
      defp encode_time_unix_nano(acc, msg) do
        try do
          if msg.time_unix_nano == 0 do
            acc
          else
            [acc, "\t", Protox.Encode.encode_fixed64(msg.time_unix_nano)]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:time_unix_nano, "invalid field value"),
                    __STACKTRACE__
        end
      end,
      defp encode_severity_number(acc, msg) do
        try do
          if msg.severity_number == :SEVERITY_NUMBER_UNSPECIFIED do
            acc
          else
            [
              acc,
              "\x10",
              msg.severity_number
              |> Opentelemetry.Proto.Logs.V1.SeverityNumber.encode()
              |> Protox.Encode.encode_enum()
            ]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:severity_number, "invalid field value"),
                    __STACKTRACE__
        end
      end,
      defp encode_severity_text(acc, msg) do
        try do
          if msg.severity_text == "" do
            acc
          else
            [acc, "\x1A", Protox.Encode.encode_string(msg.severity_text)]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:severity_text, "invalid field value"),
                    __STACKTRACE__
        end
      end,
      defp encode_body(acc, msg) do
        try do
          if msg.body == nil do
            acc
          else
            [acc, "*", Protox.Encode.encode_message(msg.body)]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:body, "invalid field value"), __STACKTRACE__
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
                  [acc, "2", Protox.Encode.encode_message(value)]
                end)
              ]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:attributes, "invalid field value"), __STACKTRACE__
        end
      end,
      defp encode_dropped_attributes_count(acc, msg) do
        try do
          if msg.dropped_attributes_count == 0 do
            acc
          else
            [acc, "8", Protox.Encode.encode_uint32(msg.dropped_attributes_count)]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:dropped_attributes_count, "invalid field value"),
                    __STACKTRACE__
        end
      end,
      defp encode_flags(acc, msg) do
        try do
          if msg.flags == 0 do
            acc
          else
            [acc, "E", Protox.Encode.encode_fixed32(msg.flags)]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:flags, "invalid field value"), __STACKTRACE__
        end
      end,
      defp encode_trace_id(acc, msg) do
        try do
          if msg.trace_id == "" do
            acc
          else
            [acc, "J", Protox.Encode.encode_bytes(msg.trace_id)]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:trace_id, "invalid field value"), __STACKTRACE__
        end
      end,
      defp encode_span_id(acc, msg) do
        try do
          if msg.span_id == "" do
            acc
          else
            [acc, "R", Protox.Encode.encode_bytes(msg.span_id)]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:span_id, "invalid field value"), __STACKTRACE__
        end
      end,
      defp encode_observed_time_unix_nano(acc, msg) do
        try do
          if msg.observed_time_unix_nano == 0 do
            acc
          else
            [acc, "Y", Protox.Encode.encode_fixed64(msg.observed_time_unix_nano)]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:observed_time_unix_nano, "invalid field value"),
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
          parse_key_value(bytes, struct(Opentelemetry.Proto.Logs.V1.LogRecord))
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
              {value, rest} = Protox.Decode.parse_fixed64(bytes)
              {[time_unix_nano: value], rest}

            {2, _, bytes} ->
              {value, rest} =
                Protox.Decode.parse_enum(bytes, Opentelemetry.Proto.Logs.V1.SeverityNumber)

              {[severity_number: value], rest}

            {3, _, bytes} ->
              {len, bytes} = Protox.Varint.decode(bytes)
              {delimited, rest} = Protox.Decode.parse_delimited(bytes, len)
              {[severity_text: delimited], rest}

            {5, _, bytes} ->
              {len, bytes} = Protox.Varint.decode(bytes)
              {delimited, rest} = Protox.Decode.parse_delimited(bytes, len)

              {[
                 body:
                   Protox.MergeMessage.merge(
                     msg.body,
                     Opentelemetry.Proto.Common.V1.AnyValue.decode!(delimited)
                   )
               ], rest}

            {6, _, bytes} ->
              {len, bytes} = Protox.Varint.decode(bytes)
              {delimited, rest} = Protox.Decode.parse_delimited(bytes, len)

              {[
                 attributes:
                   msg.attributes ++ [Opentelemetry.Proto.Common.V1.KeyValue.decode!(delimited)]
               ], rest}

            {7, _, bytes} ->
              {value, rest} = Protox.Decode.parse_uint32(bytes)
              {[dropped_attributes_count: value], rest}

            {8, _, bytes} ->
              {value, rest} = Protox.Decode.parse_fixed32(bytes)
              {[flags: value], rest}

            {9, _, bytes} ->
              {len, bytes} = Protox.Varint.decode(bytes)
              {delimited, rest} = Protox.Decode.parse_delimited(bytes, len)
              {[trace_id: delimited], rest}

            {10, _, bytes} ->
              {len, bytes} = Protox.Varint.decode(bytes)
              {delimited, rest} = Protox.Decode.parse_delimited(bytes, len)
              {[span_id: delimited], rest}

            {11, _, bytes} ->
              {value, rest} = Protox.Decode.parse_fixed64(bytes)
              {[observed_time_unix_nano: value], rest}

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
        Opentelemetry.Proto.Logs.V1.LogRecord,
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
        1 => {:time_unix_nano, {:scalar, 0}, :fixed64},
        2 =>
          {:severity_number, {:scalar, :SEVERITY_NUMBER_UNSPECIFIED},
           {:enum, Opentelemetry.Proto.Logs.V1.SeverityNumber}},
        3 => {:severity_text, {:scalar, ""}, :string},
        5 => {:body, {:scalar, nil}, {:message, Opentelemetry.Proto.Common.V1.AnyValue}},
        6 => {:attributes, :unpacked, {:message, Opentelemetry.Proto.Common.V1.KeyValue}},
        7 => {:dropped_attributes_count, {:scalar, 0}, :uint32},
        8 => {:flags, {:scalar, 0}, :fixed32},
        9 => {:trace_id, {:scalar, ""}, :bytes},
        10 => {:span_id, {:scalar, ""}, :bytes},
        11 => {:observed_time_unix_nano, {:scalar, 0}, :fixed64}
      }
    end

    @deprecated "Use fields_defs()/0 instead"
    @spec defs_by_name() :: %{
            required(atom) => {non_neg_integer, Protox.Types.kind(), Protox.Types.type()}
          }
    def defs_by_name() do
      %{
        attributes: {6, :unpacked, {:message, Opentelemetry.Proto.Common.V1.KeyValue}},
        body: {5, {:scalar, nil}, {:message, Opentelemetry.Proto.Common.V1.AnyValue}},
        dropped_attributes_count: {7, {:scalar, 0}, :uint32},
        flags: {8, {:scalar, 0}, :fixed32},
        observed_time_unix_nano: {11, {:scalar, 0}, :fixed64},
        severity_number:
          {2, {:scalar, :SEVERITY_NUMBER_UNSPECIFIED},
           {:enum, Opentelemetry.Proto.Logs.V1.SeverityNumber}},
        severity_text: {3, {:scalar, ""}, :string},
        span_id: {10, {:scalar, ""}, :bytes},
        time_unix_nano: {1, {:scalar, 0}, :fixed64},
        trace_id: {9, {:scalar, ""}, :bytes}
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
          tag: 1,
          type: :fixed64
        },
        %{
          __struct__: Protox.Field,
          json_name: "severityNumber",
          kind: {:scalar, :SEVERITY_NUMBER_UNSPECIFIED},
          label: :optional,
          name: :severity_number,
          tag: 2,
          type: {:enum, Opentelemetry.Proto.Logs.V1.SeverityNumber}
        },
        %{
          __struct__: Protox.Field,
          json_name: "severityText",
          kind: {:scalar, ""},
          label: :optional,
          name: :severity_text,
          tag: 3,
          type: :string
        },
        %{
          __struct__: Protox.Field,
          json_name: "body",
          kind: {:scalar, nil},
          label: :optional,
          name: :body,
          tag: 5,
          type: {:message, Opentelemetry.Proto.Common.V1.AnyValue}
        },
        %{
          __struct__: Protox.Field,
          json_name: "attributes",
          kind: :unpacked,
          label: :repeated,
          name: :attributes,
          tag: 6,
          type: {:message, Opentelemetry.Proto.Common.V1.KeyValue}
        },
        %{
          __struct__: Protox.Field,
          json_name: "droppedAttributesCount",
          kind: {:scalar, 0},
          label: :optional,
          name: :dropped_attributes_count,
          tag: 7,
          type: :uint32
        },
        %{
          __struct__: Protox.Field,
          json_name: "flags",
          kind: {:scalar, 0},
          label: :optional,
          name: :flags,
          tag: 8,
          type: :fixed32
        },
        %{
          __struct__: Protox.Field,
          json_name: "traceId",
          kind: {:scalar, ""},
          label: :optional,
          name: :trace_id,
          tag: 9,
          type: :bytes
        },
        %{
          __struct__: Protox.Field,
          json_name: "spanId",
          kind: {:scalar, ""},
          label: :optional,
          name: :span_id,
          tag: 10,
          type: :bytes
        },
        %{
          __struct__: Protox.Field,
          json_name: "observedTimeUnixNano",
          kind: {:scalar, 0},
          label: :optional,
          name: :observed_time_unix_nano,
          tag: 11,
          type: :fixed64
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
             tag: 1,
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
             tag: 1,
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
             tag: 1,
             type: :fixed64
           }}
        end
      ),
      (
        def field_def(:severity_number) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "severityNumber",
             kind: {:scalar, :SEVERITY_NUMBER_UNSPECIFIED},
             label: :optional,
             name: :severity_number,
             tag: 2,
             type: {:enum, Opentelemetry.Proto.Logs.V1.SeverityNumber}
           }}
        end

        def field_def("severityNumber") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "severityNumber",
             kind: {:scalar, :SEVERITY_NUMBER_UNSPECIFIED},
             label: :optional,
             name: :severity_number,
             tag: 2,
             type: {:enum, Opentelemetry.Proto.Logs.V1.SeverityNumber}
           }}
        end

        def field_def("severity_number") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "severityNumber",
             kind: {:scalar, :SEVERITY_NUMBER_UNSPECIFIED},
             label: :optional,
             name: :severity_number,
             tag: 2,
             type: {:enum, Opentelemetry.Proto.Logs.V1.SeverityNumber}
           }}
        end
      ),
      (
        def field_def(:severity_text) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "severityText",
             kind: {:scalar, ""},
             label: :optional,
             name: :severity_text,
             tag: 3,
             type: :string
           }}
        end

        def field_def("severityText") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "severityText",
             kind: {:scalar, ""},
             label: :optional,
             name: :severity_text,
             tag: 3,
             type: :string
           }}
        end

        def field_def("severity_text") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "severityText",
             kind: {:scalar, ""},
             label: :optional,
             name: :severity_text,
             tag: 3,
             type: :string
           }}
        end
      ),
      (
        def field_def(:body) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "body",
             kind: {:scalar, nil},
             label: :optional,
             name: :body,
             tag: 5,
             type: {:message, Opentelemetry.Proto.Common.V1.AnyValue}
           }}
        end

        def field_def("body") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "body",
             kind: {:scalar, nil},
             label: :optional,
             name: :body,
             tag: 5,
             type: {:message, Opentelemetry.Proto.Common.V1.AnyValue}
           }}
        end

        []
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
             tag: 6,
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
             tag: 6,
             type: {:message, Opentelemetry.Proto.Common.V1.KeyValue}
           }}
        end

        []
      ),
      (
        def field_def(:dropped_attributes_count) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "droppedAttributesCount",
             kind: {:scalar, 0},
             label: :optional,
             name: :dropped_attributes_count,
             tag: 7,
             type: :uint32
           }}
        end

        def field_def("droppedAttributesCount") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "droppedAttributesCount",
             kind: {:scalar, 0},
             label: :optional,
             name: :dropped_attributes_count,
             tag: 7,
             type: :uint32
           }}
        end

        def field_def("dropped_attributes_count") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "droppedAttributesCount",
             kind: {:scalar, 0},
             label: :optional,
             name: :dropped_attributes_count,
             tag: 7,
             type: :uint32
           }}
        end
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
             type: :fixed32
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
             type: :fixed32
           }}
        end

        []
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
             tag: 9,
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
             tag: 9,
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
             tag: 9,
             type: :bytes
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
             tag: 10,
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
             tag: 10,
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
             tag: 10,
             type: :bytes
           }}
        end
      ),
      (
        def field_def(:observed_time_unix_nano) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "observedTimeUnixNano",
             kind: {:scalar, 0},
             label: :optional,
             name: :observed_time_unix_nano,
             tag: 11,
             type: :fixed64
           }}
        end

        def field_def("observedTimeUnixNano") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "observedTimeUnixNano",
             kind: {:scalar, 0},
             label: :optional,
             name: :observed_time_unix_nano,
             tag: 11,
             type: :fixed64
           }}
        end

        def field_def("observed_time_unix_nano") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "observedTimeUnixNano",
             kind: {:scalar, 0},
             label: :optional,
             name: :observed_time_unix_nano,
             tag: 11,
             type: :fixed64
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
    def default(:severity_number) do
      {:ok, :SEVERITY_NUMBER_UNSPECIFIED}
    end,
    def default(:severity_text) do
      {:ok, ""}
    end,
    def default(:body) do
      {:ok, nil}
    end,
    def default(:attributes) do
      {:error, :no_default_value}
    end,
    def default(:dropped_attributes_count) do
      {:ok, 0}
    end,
    def default(:flags) do
      {:ok, 0}
    end,
    def default(:trace_id) do
      {:ok, ""}
    end,
    def default(:span_id) do
      {:ok, ""}
    end,
    def default(:observed_time_unix_nano) do
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
        csharp_namespace: "OpenTelemetry.Proto.Logs.V1",
        deprecated: nil,
        go_package: "go.opentelemetry.io/proto/otlp/logs/v1",
        java_generate_equals_and_hash: nil,
        java_generic_services: nil,
        java_multiple_files: true,
        java_outer_classname: "LogsProto",
        java_package: "io.opentelemetry.proto.logs.v1",
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
