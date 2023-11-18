# credo:disable-for-this-file
defmodule Opentelemetry.Proto.Trace.V1.Span do
  @moduledoc false
  defstruct trace_id: "",
            span_id: "",
            trace_state: "",
            parent_span_id: "",
            name: "",
            kind: :SPAN_KIND_UNSPECIFIED,
            start_time_unix_nano: 0,
            end_time_unix_nano: 0,
            attributes: [],
            dropped_attributes_count: 0,
            events: [],
            dropped_events_count: 0,
            links: [],
            dropped_links_count: 0,
            status: nil,
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
        |> encode_trace_id(msg)
        |> encode_span_id(msg)
        |> encode_trace_state(msg)
        |> encode_parent_span_id(msg)
        |> encode_name(msg)
        |> encode_kind(msg)
        |> encode_start_time_unix_nano(msg)
        |> encode_end_time_unix_nano(msg)
        |> encode_attributes(msg)
        |> encode_dropped_attributes_count(msg)
        |> encode_events(msg)
        |> encode_dropped_events_count(msg)
        |> encode_links(msg)
        |> encode_dropped_links_count(msg)
        |> encode_status(msg)
        |> encode_unknown_fields(msg)
      end
    )

    []

    [
      defp encode_trace_id(acc, msg) do
        try do
          if msg.trace_id == "" do
            acc
          else
            [acc, "\n", Protox.Encode.encode_bytes(msg.trace_id)]
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
            [acc, "\x12", Protox.Encode.encode_bytes(msg.span_id)]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:span_id, "invalid field value"), __STACKTRACE__
        end
      end,
      defp encode_trace_state(acc, msg) do
        try do
          if msg.trace_state == "" do
            acc
          else
            [acc, "\x1A", Protox.Encode.encode_string(msg.trace_state)]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:trace_state, "invalid field value"), __STACKTRACE__
        end
      end,
      defp encode_parent_span_id(acc, msg) do
        try do
          if msg.parent_span_id == "" do
            acc
          else
            [acc, "\"", Protox.Encode.encode_bytes(msg.parent_span_id)]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:parent_span_id, "invalid field value"),
                    __STACKTRACE__
        end
      end,
      defp encode_name(acc, msg) do
        try do
          if msg.name == "" do
            acc
          else
            [acc, "*", Protox.Encode.encode_string(msg.name)]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:name, "invalid field value"), __STACKTRACE__
        end
      end,
      defp encode_kind(acc, msg) do
        try do
          if msg.kind == :SPAN_KIND_UNSPECIFIED do
            acc
          else
            [
              acc,
              "0",
              msg.kind
              |> Opentelemetry.Proto.Trace.V1.Span.SpanKind.encode()
              |> Protox.Encode.encode_enum()
            ]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:kind, "invalid field value"), __STACKTRACE__
        end
      end,
      defp encode_start_time_unix_nano(acc, msg) do
        try do
          if msg.start_time_unix_nano == 0 do
            acc
          else
            [acc, "9", Protox.Encode.encode_fixed64(msg.start_time_unix_nano)]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:start_time_unix_nano, "invalid field value"),
                    __STACKTRACE__
        end
      end,
      defp encode_end_time_unix_nano(acc, msg) do
        try do
          if msg.end_time_unix_nano == 0 do
            acc
          else
            [acc, "A", Protox.Encode.encode_fixed64(msg.end_time_unix_nano)]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:end_time_unix_nano, "invalid field value"),
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
                  [acc, "J", Protox.Encode.encode_message(value)]
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
            [acc, "P", Protox.Encode.encode_uint32(msg.dropped_attributes_count)]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:dropped_attributes_count, "invalid field value"),
                    __STACKTRACE__
        end
      end,
      defp encode_events(acc, msg) do
        try do
          case msg.events do
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
            reraise Protox.EncodingError.new(:events, "invalid field value"), __STACKTRACE__
        end
      end,
      defp encode_dropped_events_count(acc, msg) do
        try do
          if msg.dropped_events_count == 0 do
            acc
          else
            [acc, "`", Protox.Encode.encode_uint32(msg.dropped_events_count)]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:dropped_events_count, "invalid field value"),
                    __STACKTRACE__
        end
      end,
      defp encode_links(acc, msg) do
        try do
          case msg.links do
            [] ->
              acc

            values ->
              [
                acc,
                Enum.reduce(values, [], fn value, acc ->
                  [acc, "j", Protox.Encode.encode_message(value)]
                end)
              ]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:links, "invalid field value"), __STACKTRACE__
        end
      end,
      defp encode_dropped_links_count(acc, msg) do
        try do
          if msg.dropped_links_count == 0 do
            acc
          else
            [acc, "p", Protox.Encode.encode_uint32(msg.dropped_links_count)]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:dropped_links_count, "invalid field value"),
                    __STACKTRACE__
        end
      end,
      defp encode_status(acc, msg) do
        try do
          if msg.status == nil do
            acc
          else
            [acc, "z", Protox.Encode.encode_message(msg.status)]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:status, "invalid field value"), __STACKTRACE__
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
          parse_key_value(bytes, struct(Opentelemetry.Proto.Trace.V1.Span))
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
              {[trace_id: delimited], rest}

            {2, _, bytes} ->
              {len, bytes} = Protox.Varint.decode(bytes)
              {delimited, rest} = Protox.Decode.parse_delimited(bytes, len)
              {[span_id: delimited], rest}

            {3, _, bytes} ->
              {len, bytes} = Protox.Varint.decode(bytes)
              {delimited, rest} = Protox.Decode.parse_delimited(bytes, len)
              {[trace_state: delimited], rest}

            {4, _, bytes} ->
              {len, bytes} = Protox.Varint.decode(bytes)
              {delimited, rest} = Protox.Decode.parse_delimited(bytes, len)
              {[parent_span_id: delimited], rest}

            {5, _, bytes} ->
              {len, bytes} = Protox.Varint.decode(bytes)
              {delimited, rest} = Protox.Decode.parse_delimited(bytes, len)
              {[name: delimited], rest}

            {6, _, bytes} ->
              {value, rest} =
                Protox.Decode.parse_enum(bytes, Opentelemetry.Proto.Trace.V1.Span.SpanKind)

              {[kind: value], rest}

            {7, _, bytes} ->
              {value, rest} = Protox.Decode.parse_fixed64(bytes)
              {[start_time_unix_nano: value], rest}

            {8, _, bytes} ->
              {value, rest} = Protox.Decode.parse_fixed64(bytes)
              {[end_time_unix_nano: value], rest}

            {9, _, bytes} ->
              {len, bytes} = Protox.Varint.decode(bytes)
              {delimited, rest} = Protox.Decode.parse_delimited(bytes, len)

              {[
                 attributes:
                   msg.attributes ++ [Opentelemetry.Proto.Common.V1.KeyValue.decode!(delimited)]
               ], rest}

            {10, _, bytes} ->
              {value, rest} = Protox.Decode.parse_uint32(bytes)
              {[dropped_attributes_count: value], rest}

            {11, _, bytes} ->
              {len, bytes} = Protox.Varint.decode(bytes)
              {delimited, rest} = Protox.Decode.parse_delimited(bytes, len)

              {[
                 events:
                   msg.events ++ [Opentelemetry.Proto.Trace.V1.Span.Event.decode!(delimited)]
               ], rest}

            {12, _, bytes} ->
              {value, rest} = Protox.Decode.parse_uint32(bytes)
              {[dropped_events_count: value], rest}

            {13, _, bytes} ->
              {len, bytes} = Protox.Varint.decode(bytes)
              {delimited, rest} = Protox.Decode.parse_delimited(bytes, len)

              {[links: msg.links ++ [Opentelemetry.Proto.Trace.V1.Span.Link.decode!(delimited)]],
               rest}

            {14, _, bytes} ->
              {value, rest} = Protox.Decode.parse_uint32(bytes)
              {[dropped_links_count: value], rest}

            {15, _, bytes} ->
              {len, bytes} = Protox.Varint.decode(bytes)
              {delimited, rest} = Protox.Decode.parse_delimited(bytes, len)

              {[
                 status:
                   Protox.MergeMessage.merge(
                     msg.status,
                     Opentelemetry.Proto.Trace.V1.Status.decode!(delimited)
                   )
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
        Opentelemetry.Proto.Trace.V1.Span,
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
        1 => {:trace_id, {:scalar, ""}, :bytes},
        2 => {:span_id, {:scalar, ""}, :bytes},
        3 => {:trace_state, {:scalar, ""}, :string},
        4 => {:parent_span_id, {:scalar, ""}, :bytes},
        5 => {:name, {:scalar, ""}, :string},
        6 =>
          {:kind, {:scalar, :SPAN_KIND_UNSPECIFIED},
           {:enum, Opentelemetry.Proto.Trace.V1.Span.SpanKind}},
        7 => {:start_time_unix_nano, {:scalar, 0}, :fixed64},
        8 => {:end_time_unix_nano, {:scalar, 0}, :fixed64},
        9 => {:attributes, :unpacked, {:message, Opentelemetry.Proto.Common.V1.KeyValue}},
        10 => {:dropped_attributes_count, {:scalar, 0}, :uint32},
        11 => {:events, :unpacked, {:message, Opentelemetry.Proto.Trace.V1.Span.Event}},
        12 => {:dropped_events_count, {:scalar, 0}, :uint32},
        13 => {:links, :unpacked, {:message, Opentelemetry.Proto.Trace.V1.Span.Link}},
        14 => {:dropped_links_count, {:scalar, 0}, :uint32},
        15 => {:status, {:scalar, nil}, {:message, Opentelemetry.Proto.Trace.V1.Status}}
      }
    end

    @deprecated "Use fields_defs()/0 instead"
    @spec defs_by_name() :: %{
            required(atom) => {non_neg_integer, Protox.Types.kind(), Protox.Types.type()}
          }
    def defs_by_name() do
      %{
        attributes: {9, :unpacked, {:message, Opentelemetry.Proto.Common.V1.KeyValue}},
        dropped_attributes_count: {10, {:scalar, 0}, :uint32},
        dropped_events_count: {12, {:scalar, 0}, :uint32},
        dropped_links_count: {14, {:scalar, 0}, :uint32},
        end_time_unix_nano: {8, {:scalar, 0}, :fixed64},
        events: {11, :unpacked, {:message, Opentelemetry.Proto.Trace.V1.Span.Event}},
        kind:
          {6, {:scalar, :SPAN_KIND_UNSPECIFIED},
           {:enum, Opentelemetry.Proto.Trace.V1.Span.SpanKind}},
        links: {13, :unpacked, {:message, Opentelemetry.Proto.Trace.V1.Span.Link}},
        name: {5, {:scalar, ""}, :string},
        parent_span_id: {4, {:scalar, ""}, :bytes},
        span_id: {2, {:scalar, ""}, :bytes},
        start_time_unix_nano: {7, {:scalar, 0}, :fixed64},
        status: {15, {:scalar, nil}, {:message, Opentelemetry.Proto.Trace.V1.Status}},
        trace_id: {1, {:scalar, ""}, :bytes},
        trace_state: {3, {:scalar, ""}, :string}
      }
    end
  )

  (
    @spec fields_defs() :: list(Protox.Field.t())
    def fields_defs() do
      [
        %{
          __struct__: Protox.Field,
          json_name: "traceId",
          kind: {:scalar, ""},
          label: :optional,
          name: :trace_id,
          tag: 1,
          type: :bytes
        },
        %{
          __struct__: Protox.Field,
          json_name: "spanId",
          kind: {:scalar, ""},
          label: :optional,
          name: :span_id,
          tag: 2,
          type: :bytes
        },
        %{
          __struct__: Protox.Field,
          json_name: "traceState",
          kind: {:scalar, ""},
          label: :optional,
          name: :trace_state,
          tag: 3,
          type: :string
        },
        %{
          __struct__: Protox.Field,
          json_name: "parentSpanId",
          kind: {:scalar, ""},
          label: :optional,
          name: :parent_span_id,
          tag: 4,
          type: :bytes
        },
        %{
          __struct__: Protox.Field,
          json_name: "name",
          kind: {:scalar, ""},
          label: :optional,
          name: :name,
          tag: 5,
          type: :string
        },
        %{
          __struct__: Protox.Field,
          json_name: "kind",
          kind: {:scalar, :SPAN_KIND_UNSPECIFIED},
          label: :optional,
          name: :kind,
          tag: 6,
          type: {:enum, Opentelemetry.Proto.Trace.V1.Span.SpanKind}
        },
        %{
          __struct__: Protox.Field,
          json_name: "startTimeUnixNano",
          kind: {:scalar, 0},
          label: :optional,
          name: :start_time_unix_nano,
          tag: 7,
          type: :fixed64
        },
        %{
          __struct__: Protox.Field,
          json_name: "endTimeUnixNano",
          kind: {:scalar, 0},
          label: :optional,
          name: :end_time_unix_nano,
          tag: 8,
          type: :fixed64
        },
        %{
          __struct__: Protox.Field,
          json_name: "attributes",
          kind: :unpacked,
          label: :repeated,
          name: :attributes,
          tag: 9,
          type: {:message, Opentelemetry.Proto.Common.V1.KeyValue}
        },
        %{
          __struct__: Protox.Field,
          json_name: "droppedAttributesCount",
          kind: {:scalar, 0},
          label: :optional,
          name: :dropped_attributes_count,
          tag: 10,
          type: :uint32
        },
        %{
          __struct__: Protox.Field,
          json_name: "events",
          kind: :unpacked,
          label: :repeated,
          name: :events,
          tag: 11,
          type: {:message, Opentelemetry.Proto.Trace.V1.Span.Event}
        },
        %{
          __struct__: Protox.Field,
          json_name: "droppedEventsCount",
          kind: {:scalar, 0},
          label: :optional,
          name: :dropped_events_count,
          tag: 12,
          type: :uint32
        },
        %{
          __struct__: Protox.Field,
          json_name: "links",
          kind: :unpacked,
          label: :repeated,
          name: :links,
          tag: 13,
          type: {:message, Opentelemetry.Proto.Trace.V1.Span.Link}
        },
        %{
          __struct__: Protox.Field,
          json_name: "droppedLinksCount",
          kind: {:scalar, 0},
          label: :optional,
          name: :dropped_links_count,
          tag: 14,
          type: :uint32
        },
        %{
          __struct__: Protox.Field,
          json_name: "status",
          kind: {:scalar, nil},
          label: :optional,
          name: :status,
          tag: 15,
          type: {:message, Opentelemetry.Proto.Trace.V1.Status}
        }
      ]
    end

    [
      @spec(field_def(atom) :: {:ok, Protox.Field.t()} | {:error, :no_such_field}),
      (
        def field_def(:trace_id) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "traceId",
             kind: {:scalar, ""},
             label: :optional,
             name: :trace_id,
             tag: 1,
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
             tag: 1,
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
             tag: 1,
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
             tag: 2,
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
             tag: 2,
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
             tag: 2,
             type: :bytes
           }}
        end
      ),
      (
        def field_def(:trace_state) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "traceState",
             kind: {:scalar, ""},
             label: :optional,
             name: :trace_state,
             tag: 3,
             type: :string
           }}
        end

        def field_def("traceState") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "traceState",
             kind: {:scalar, ""},
             label: :optional,
             name: :trace_state,
             tag: 3,
             type: :string
           }}
        end

        def field_def("trace_state") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "traceState",
             kind: {:scalar, ""},
             label: :optional,
             name: :trace_state,
             tag: 3,
             type: :string
           }}
        end
      ),
      (
        def field_def(:parent_span_id) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "parentSpanId",
             kind: {:scalar, ""},
             label: :optional,
             name: :parent_span_id,
             tag: 4,
             type: :bytes
           }}
        end

        def field_def("parentSpanId") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "parentSpanId",
             kind: {:scalar, ""},
             label: :optional,
             name: :parent_span_id,
             tag: 4,
             type: :bytes
           }}
        end

        def field_def("parent_span_id") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "parentSpanId",
             kind: {:scalar, ""},
             label: :optional,
             name: :parent_span_id,
             tag: 4,
             type: :bytes
           }}
        end
      ),
      (
        def field_def(:name) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "name",
             kind: {:scalar, ""},
             label: :optional,
             name: :name,
             tag: 5,
             type: :string
           }}
        end

        def field_def("name") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "name",
             kind: {:scalar, ""},
             label: :optional,
             name: :name,
             tag: 5,
             type: :string
           }}
        end

        []
      ),
      (
        def field_def(:kind) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "kind",
             kind: {:scalar, :SPAN_KIND_UNSPECIFIED},
             label: :optional,
             name: :kind,
             tag: 6,
             type: {:enum, Opentelemetry.Proto.Trace.V1.Span.SpanKind}
           }}
        end

        def field_def("kind") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "kind",
             kind: {:scalar, :SPAN_KIND_UNSPECIFIED},
             label: :optional,
             name: :kind,
             tag: 6,
             type: {:enum, Opentelemetry.Proto.Trace.V1.Span.SpanKind}
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
             tag: 7,
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
             tag: 7,
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
             tag: 7,
             type: :fixed64
           }}
        end
      ),
      (
        def field_def(:end_time_unix_nano) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "endTimeUnixNano",
             kind: {:scalar, 0},
             label: :optional,
             name: :end_time_unix_nano,
             tag: 8,
             type: :fixed64
           }}
        end

        def field_def("endTimeUnixNano") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "endTimeUnixNano",
             kind: {:scalar, 0},
             label: :optional,
             name: :end_time_unix_nano,
             tag: 8,
             type: :fixed64
           }}
        end

        def field_def("end_time_unix_nano") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "endTimeUnixNano",
             kind: {:scalar, 0},
             label: :optional,
             name: :end_time_unix_nano,
             tag: 8,
             type: :fixed64
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
             tag: 9,
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
             tag: 9,
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
             tag: 10,
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
             tag: 10,
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
             tag: 10,
             type: :uint32
           }}
        end
      ),
      (
        def field_def(:events) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "events",
             kind: :unpacked,
             label: :repeated,
             name: :events,
             tag: 11,
             type: {:message, Opentelemetry.Proto.Trace.V1.Span.Event}
           }}
        end

        def field_def("events") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "events",
             kind: :unpacked,
             label: :repeated,
             name: :events,
             tag: 11,
             type: {:message, Opentelemetry.Proto.Trace.V1.Span.Event}
           }}
        end

        []
      ),
      (
        def field_def(:dropped_events_count) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "droppedEventsCount",
             kind: {:scalar, 0},
             label: :optional,
             name: :dropped_events_count,
             tag: 12,
             type: :uint32
           }}
        end

        def field_def("droppedEventsCount") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "droppedEventsCount",
             kind: {:scalar, 0},
             label: :optional,
             name: :dropped_events_count,
             tag: 12,
             type: :uint32
           }}
        end

        def field_def("dropped_events_count") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "droppedEventsCount",
             kind: {:scalar, 0},
             label: :optional,
             name: :dropped_events_count,
             tag: 12,
             type: :uint32
           }}
        end
      ),
      (
        def field_def(:links) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "links",
             kind: :unpacked,
             label: :repeated,
             name: :links,
             tag: 13,
             type: {:message, Opentelemetry.Proto.Trace.V1.Span.Link}
           }}
        end

        def field_def("links") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "links",
             kind: :unpacked,
             label: :repeated,
             name: :links,
             tag: 13,
             type: {:message, Opentelemetry.Proto.Trace.V1.Span.Link}
           }}
        end

        []
      ),
      (
        def field_def(:dropped_links_count) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "droppedLinksCount",
             kind: {:scalar, 0},
             label: :optional,
             name: :dropped_links_count,
             tag: 14,
             type: :uint32
           }}
        end

        def field_def("droppedLinksCount") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "droppedLinksCount",
             kind: {:scalar, 0},
             label: :optional,
             name: :dropped_links_count,
             tag: 14,
             type: :uint32
           }}
        end

        def field_def("dropped_links_count") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "droppedLinksCount",
             kind: {:scalar, 0},
             label: :optional,
             name: :dropped_links_count,
             tag: 14,
             type: :uint32
           }}
        end
      ),
      (
        def field_def(:status) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "status",
             kind: {:scalar, nil},
             label: :optional,
             name: :status,
             tag: 15,
             type: {:message, Opentelemetry.Proto.Trace.V1.Status}
           }}
        end

        def field_def("status") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "status",
             kind: {:scalar, nil},
             label: :optional,
             name: :status,
             tag: 15,
             type: {:message, Opentelemetry.Proto.Trace.V1.Status}
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
    def default(:trace_id) do
      {:ok, ""}
    end,
    def default(:span_id) do
      {:ok, ""}
    end,
    def default(:trace_state) do
      {:ok, ""}
    end,
    def default(:parent_span_id) do
      {:ok, ""}
    end,
    def default(:name) do
      {:ok, ""}
    end,
    def default(:kind) do
      {:ok, :SPAN_KIND_UNSPECIFIED}
    end,
    def default(:start_time_unix_nano) do
      {:ok, 0}
    end,
    def default(:end_time_unix_nano) do
      {:ok, 0}
    end,
    def default(:attributes) do
      {:error, :no_default_value}
    end,
    def default(:dropped_attributes_count) do
      {:ok, 0}
    end,
    def default(:events) do
      {:error, :no_default_value}
    end,
    def default(:dropped_events_count) do
      {:ok, 0}
    end,
    def default(:links) do
      {:error, :no_default_value}
    end,
    def default(:dropped_links_count) do
      {:ok, 0}
    end,
    def default(:status) do
      {:ok, nil}
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
        csharp_namespace: "OpenTelemetry.Proto.Trace.V1",
        deprecated: nil,
        go_package: "go.opentelemetry.io/proto/otlp/trace/v1",
        java_generate_equals_and_hash: nil,
        java_generic_services: nil,
        java_multiple_files: true,
        java_outer_classname: "TraceProto",
        java_package: "io.opentelemetry.proto.trace.v1",
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
