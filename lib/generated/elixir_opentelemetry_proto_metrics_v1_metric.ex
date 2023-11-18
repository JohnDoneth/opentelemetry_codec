# credo:disable-for-this-file
defmodule Opentelemetry.Proto.Metrics.V1.Metric do
  @moduledoc false
  defstruct name: "", description: "", unit: "", data: nil, __uf__: []

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
        |> encode_data(msg)
        |> encode_name(msg)
        |> encode_description(msg)
        |> encode_unit(msg)
        |> encode_unknown_fields(msg)
      end
    )

    [
      defp encode_data(acc, msg) do
        case msg.data do
          nil -> acc
          {:gauge, _field_value} -> encode_gauge(acc, msg)
          {:sum, _field_value} -> encode_sum(acc, msg)
          {:histogram, _field_value} -> encode_histogram(acc, msg)
          {:exponential_histogram, _field_value} -> encode_exponential_histogram(acc, msg)
          {:summary, _field_value} -> encode_summary(acc, msg)
        end
      end
    ]

    [
      defp encode_name(acc, msg) do
        try do
          if msg.name == "" do
            acc
          else
            [acc, "\n", Protox.Encode.encode_string(msg.name)]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:name, "invalid field value"), __STACKTRACE__
        end
      end,
      defp encode_description(acc, msg) do
        try do
          if msg.description == "" do
            acc
          else
            [acc, "\x12", Protox.Encode.encode_string(msg.description)]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:description, "invalid field value"), __STACKTRACE__
        end
      end,
      defp encode_unit(acc, msg) do
        try do
          if msg.unit == "" do
            acc
          else
            [acc, "\x1A", Protox.Encode.encode_string(msg.unit)]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:unit, "invalid field value"), __STACKTRACE__
        end
      end,
      defp encode_gauge(acc, msg) do
        try do
          {_, child_field_value} = msg.data
          [acc, "*", Protox.Encode.encode_message(child_field_value)]
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:gauge, "invalid field value"), __STACKTRACE__
        end
      end,
      defp encode_sum(acc, msg) do
        try do
          {_, child_field_value} = msg.data
          [acc, ":", Protox.Encode.encode_message(child_field_value)]
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:sum, "invalid field value"), __STACKTRACE__
        end
      end,
      defp encode_histogram(acc, msg) do
        try do
          {_, child_field_value} = msg.data
          [acc, "J", Protox.Encode.encode_message(child_field_value)]
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:histogram, "invalid field value"), __STACKTRACE__
        end
      end,
      defp encode_exponential_histogram(acc, msg) do
        try do
          {_, child_field_value} = msg.data
          [acc, "R", Protox.Encode.encode_message(child_field_value)]
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:exponential_histogram, "invalid field value"),
                    __STACKTRACE__
        end
      end,
      defp encode_summary(acc, msg) do
        try do
          {_, child_field_value} = msg.data
          [acc, "Z", Protox.Encode.encode_message(child_field_value)]
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:summary, "invalid field value"), __STACKTRACE__
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
          parse_key_value(bytes, struct(Opentelemetry.Proto.Metrics.V1.Metric))
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
              {[name: delimited], rest}

            {2, _, bytes} ->
              {len, bytes} = Protox.Varint.decode(bytes)
              {delimited, rest} = Protox.Decode.parse_delimited(bytes, len)
              {[description: delimited], rest}

            {3, _, bytes} ->
              {len, bytes} = Protox.Varint.decode(bytes)
              {delimited, rest} = Protox.Decode.parse_delimited(bytes, len)
              {[unit: delimited], rest}

            {5, _, bytes} ->
              {len, bytes} = Protox.Varint.decode(bytes)
              {delimited, rest} = Protox.Decode.parse_delimited(bytes, len)

              {[
                 case msg.data do
                   {:gauge, previous_value} ->
                     {:data,
                      {:gauge,
                       Protox.MergeMessage.merge(
                         previous_value,
                         Opentelemetry.Proto.Metrics.V1.Gauge.decode!(delimited)
                       )}}

                   _ ->
                     {:data, {:gauge, Opentelemetry.Proto.Metrics.V1.Gauge.decode!(delimited)}}
                 end
               ], rest}

            {7, _, bytes} ->
              {len, bytes} = Protox.Varint.decode(bytes)
              {delimited, rest} = Protox.Decode.parse_delimited(bytes, len)

              {[
                 case msg.data do
                   {:sum, previous_value} ->
                     {:data,
                      {:sum,
                       Protox.MergeMessage.merge(
                         previous_value,
                         Opentelemetry.Proto.Metrics.V1.Sum.decode!(delimited)
                       )}}

                   _ ->
                     {:data, {:sum, Opentelemetry.Proto.Metrics.V1.Sum.decode!(delimited)}}
                 end
               ], rest}

            {9, _, bytes} ->
              {len, bytes} = Protox.Varint.decode(bytes)
              {delimited, rest} = Protox.Decode.parse_delimited(bytes, len)

              {[
                 case msg.data do
                   {:histogram, previous_value} ->
                     {:data,
                      {:histogram,
                       Protox.MergeMessage.merge(
                         previous_value,
                         Opentelemetry.Proto.Metrics.V1.Histogram.decode!(delimited)
                       )}}

                   _ ->
                     {:data,
                      {:histogram, Opentelemetry.Proto.Metrics.V1.Histogram.decode!(delimited)}}
                 end
               ], rest}

            {10, _, bytes} ->
              {len, bytes} = Protox.Varint.decode(bytes)
              {delimited, rest} = Protox.Decode.parse_delimited(bytes, len)

              {[
                 case msg.data do
                   {:exponential_histogram, previous_value} ->
                     {:data,
                      {:exponential_histogram,
                       Protox.MergeMessage.merge(
                         previous_value,
                         Opentelemetry.Proto.Metrics.V1.ExponentialHistogram.decode!(delimited)
                       )}}

                   _ ->
                     {:data,
                      {:exponential_histogram,
                       Opentelemetry.Proto.Metrics.V1.ExponentialHistogram.decode!(delimited)}}
                 end
               ], rest}

            {11, _, bytes} ->
              {len, bytes} = Protox.Varint.decode(bytes)
              {delimited, rest} = Protox.Decode.parse_delimited(bytes, len)

              {[
                 case msg.data do
                   {:summary, previous_value} ->
                     {:data,
                      {:summary,
                       Protox.MergeMessage.merge(
                         previous_value,
                         Opentelemetry.Proto.Metrics.V1.Summary.decode!(delimited)
                       )}}

                   _ ->
                     {:data,
                      {:summary, Opentelemetry.Proto.Metrics.V1.Summary.decode!(delimited)}}
                 end
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
        Opentelemetry.Proto.Metrics.V1.Metric,
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
        1 => {:name, {:scalar, ""}, :string},
        2 => {:description, {:scalar, ""}, :string},
        3 => {:unit, {:scalar, ""}, :string},
        5 => {:gauge, {:oneof, :data}, {:message, Opentelemetry.Proto.Metrics.V1.Gauge}},
        7 => {:sum, {:oneof, :data}, {:message, Opentelemetry.Proto.Metrics.V1.Sum}},
        9 => {:histogram, {:oneof, :data}, {:message, Opentelemetry.Proto.Metrics.V1.Histogram}},
        10 =>
          {:exponential_histogram, {:oneof, :data},
           {:message, Opentelemetry.Proto.Metrics.V1.ExponentialHistogram}},
        11 => {:summary, {:oneof, :data}, {:message, Opentelemetry.Proto.Metrics.V1.Summary}}
      }
    end

    @deprecated "Use fields_defs()/0 instead"
    @spec defs_by_name() :: %{
            required(atom) => {non_neg_integer, Protox.Types.kind(), Protox.Types.type()}
          }
    def defs_by_name() do
      %{
        description: {2, {:scalar, ""}, :string},
        exponential_histogram:
          {10, {:oneof, :data}, {:message, Opentelemetry.Proto.Metrics.V1.ExponentialHistogram}},
        gauge: {5, {:oneof, :data}, {:message, Opentelemetry.Proto.Metrics.V1.Gauge}},
        histogram: {9, {:oneof, :data}, {:message, Opentelemetry.Proto.Metrics.V1.Histogram}},
        name: {1, {:scalar, ""}, :string},
        sum: {7, {:oneof, :data}, {:message, Opentelemetry.Proto.Metrics.V1.Sum}},
        summary: {11, {:oneof, :data}, {:message, Opentelemetry.Proto.Metrics.V1.Summary}},
        unit: {3, {:scalar, ""}, :string}
      }
    end
  )

  (
    @spec fields_defs() :: list(Protox.Field.t())
    def fields_defs() do
      [
        %{
          __struct__: Protox.Field,
          json_name: "name",
          kind: {:scalar, ""},
          label: :optional,
          name: :name,
          tag: 1,
          type: :string
        },
        %{
          __struct__: Protox.Field,
          json_name: "description",
          kind: {:scalar, ""},
          label: :optional,
          name: :description,
          tag: 2,
          type: :string
        },
        %{
          __struct__: Protox.Field,
          json_name: "unit",
          kind: {:scalar, ""},
          label: :optional,
          name: :unit,
          tag: 3,
          type: :string
        },
        %{
          __struct__: Protox.Field,
          json_name: "gauge",
          kind: {:oneof, :data},
          label: :optional,
          name: :gauge,
          tag: 5,
          type: {:message, Opentelemetry.Proto.Metrics.V1.Gauge}
        },
        %{
          __struct__: Protox.Field,
          json_name: "sum",
          kind: {:oneof, :data},
          label: :optional,
          name: :sum,
          tag: 7,
          type: {:message, Opentelemetry.Proto.Metrics.V1.Sum}
        },
        %{
          __struct__: Protox.Field,
          json_name: "histogram",
          kind: {:oneof, :data},
          label: :optional,
          name: :histogram,
          tag: 9,
          type: {:message, Opentelemetry.Proto.Metrics.V1.Histogram}
        },
        %{
          __struct__: Protox.Field,
          json_name: "exponentialHistogram",
          kind: {:oneof, :data},
          label: :optional,
          name: :exponential_histogram,
          tag: 10,
          type: {:message, Opentelemetry.Proto.Metrics.V1.ExponentialHistogram}
        },
        %{
          __struct__: Protox.Field,
          json_name: "summary",
          kind: {:oneof, :data},
          label: :optional,
          name: :summary,
          tag: 11,
          type: {:message, Opentelemetry.Proto.Metrics.V1.Summary}
        }
      ]
    end

    [
      @spec(field_def(atom) :: {:ok, Protox.Field.t()} | {:error, :no_such_field}),
      (
        def field_def(:name) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "name",
             kind: {:scalar, ""},
             label: :optional,
             name: :name,
             tag: 1,
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
             tag: 1,
             type: :string
           }}
        end

        []
      ),
      (
        def field_def(:description) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "description",
             kind: {:scalar, ""},
             label: :optional,
             name: :description,
             tag: 2,
             type: :string
           }}
        end

        def field_def("description") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "description",
             kind: {:scalar, ""},
             label: :optional,
             name: :description,
             tag: 2,
             type: :string
           }}
        end

        []
      ),
      (
        def field_def(:unit) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "unit",
             kind: {:scalar, ""},
             label: :optional,
             name: :unit,
             tag: 3,
             type: :string
           }}
        end

        def field_def("unit") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "unit",
             kind: {:scalar, ""},
             label: :optional,
             name: :unit,
             tag: 3,
             type: :string
           }}
        end

        []
      ),
      (
        def field_def(:gauge) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "gauge",
             kind: {:oneof, :data},
             label: :optional,
             name: :gauge,
             tag: 5,
             type: {:message, Opentelemetry.Proto.Metrics.V1.Gauge}
           }}
        end

        def field_def("gauge") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "gauge",
             kind: {:oneof, :data},
             label: :optional,
             name: :gauge,
             tag: 5,
             type: {:message, Opentelemetry.Proto.Metrics.V1.Gauge}
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
             kind: {:oneof, :data},
             label: :optional,
             name: :sum,
             tag: 7,
             type: {:message, Opentelemetry.Proto.Metrics.V1.Sum}
           }}
        end

        def field_def("sum") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "sum",
             kind: {:oneof, :data},
             label: :optional,
             name: :sum,
             tag: 7,
             type: {:message, Opentelemetry.Proto.Metrics.V1.Sum}
           }}
        end

        []
      ),
      (
        def field_def(:histogram) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "histogram",
             kind: {:oneof, :data},
             label: :optional,
             name: :histogram,
             tag: 9,
             type: {:message, Opentelemetry.Proto.Metrics.V1.Histogram}
           }}
        end

        def field_def("histogram") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "histogram",
             kind: {:oneof, :data},
             label: :optional,
             name: :histogram,
             tag: 9,
             type: {:message, Opentelemetry.Proto.Metrics.V1.Histogram}
           }}
        end

        []
      ),
      (
        def field_def(:exponential_histogram) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "exponentialHistogram",
             kind: {:oneof, :data},
             label: :optional,
             name: :exponential_histogram,
             tag: 10,
             type: {:message, Opentelemetry.Proto.Metrics.V1.ExponentialHistogram}
           }}
        end

        def field_def("exponentialHistogram") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "exponentialHistogram",
             kind: {:oneof, :data},
             label: :optional,
             name: :exponential_histogram,
             tag: 10,
             type: {:message, Opentelemetry.Proto.Metrics.V1.ExponentialHistogram}
           }}
        end

        def field_def("exponential_histogram") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "exponentialHistogram",
             kind: {:oneof, :data},
             label: :optional,
             name: :exponential_histogram,
             tag: 10,
             type: {:message, Opentelemetry.Proto.Metrics.V1.ExponentialHistogram}
           }}
        end
      ),
      (
        def field_def(:summary) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "summary",
             kind: {:oneof, :data},
             label: :optional,
             name: :summary,
             tag: 11,
             type: {:message, Opentelemetry.Proto.Metrics.V1.Summary}
           }}
        end

        def field_def("summary") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "summary",
             kind: {:oneof, :data},
             label: :optional,
             name: :summary,
             tag: 11,
             type: {:message, Opentelemetry.Proto.Metrics.V1.Summary}
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
    def default(:name) do
      {:ok, ""}
    end,
    def default(:description) do
      {:ok, ""}
    end,
    def default(:unit) do
      {:ok, ""}
    end,
    def default(:gauge) do
      {:error, :no_default_value}
    end,
    def default(:sum) do
      {:error, :no_default_value}
    end,
    def default(:histogram) do
      {:error, :no_default_value}
    end,
    def default(:exponential_histogram) do
      {:error, :no_default_value}
    end,
    def default(:summary) do
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
