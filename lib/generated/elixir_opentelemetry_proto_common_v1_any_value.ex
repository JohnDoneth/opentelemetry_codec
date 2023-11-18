# credo:disable-for-this-file
defmodule Opentelemetry.Proto.Common.V1.AnyValue do
  @moduledoc false
  defstruct value: nil, __uf__: []

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
        [] |> encode_value(msg) |> encode_unknown_fields(msg)
      end
    )

    [
      defp encode_value(acc, msg) do
        case msg.value do
          nil -> acc
          {:string_value, _field_value} -> encode_string_value(acc, msg)
          {:bool_value, _field_value} -> encode_bool_value(acc, msg)
          {:int_value, _field_value} -> encode_int_value(acc, msg)
          {:double_value, _field_value} -> encode_double_value(acc, msg)
          {:array_value, _field_value} -> encode_array_value(acc, msg)
          {:kvlist_value, _field_value} -> encode_kvlist_value(acc, msg)
          {:bytes_value, _field_value} -> encode_bytes_value(acc, msg)
        end
      end
    ]

    [
      defp encode_string_value(acc, msg) do
        try do
          {_, child_field_value} = msg.value
          [acc, "\n", Protox.Encode.encode_string(child_field_value)]
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:string_value, "invalid field value"), __STACKTRACE__
        end
      end,
      defp encode_bool_value(acc, msg) do
        try do
          {_, child_field_value} = msg.value
          [acc, "\x10", Protox.Encode.encode_bool(child_field_value)]
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:bool_value, "invalid field value"), __STACKTRACE__
        end
      end,
      defp encode_int_value(acc, msg) do
        try do
          {_, child_field_value} = msg.value
          [acc, "\x18", Protox.Encode.encode_int64(child_field_value)]
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:int_value, "invalid field value"), __STACKTRACE__
        end
      end,
      defp encode_double_value(acc, msg) do
        try do
          {_, child_field_value} = msg.value
          [acc, "!", Protox.Encode.encode_double(child_field_value)]
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:double_value, "invalid field value"), __STACKTRACE__
        end
      end,
      defp encode_array_value(acc, msg) do
        try do
          {_, child_field_value} = msg.value
          [acc, "*", Protox.Encode.encode_message(child_field_value)]
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:array_value, "invalid field value"), __STACKTRACE__
        end
      end,
      defp encode_kvlist_value(acc, msg) do
        try do
          {_, child_field_value} = msg.value
          [acc, "2", Protox.Encode.encode_message(child_field_value)]
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:kvlist_value, "invalid field value"), __STACKTRACE__
        end
      end,
      defp encode_bytes_value(acc, msg) do
        try do
          {_, child_field_value} = msg.value
          [acc, ":", Protox.Encode.encode_bytes(child_field_value)]
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:bytes_value, "invalid field value"), __STACKTRACE__
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
          parse_key_value(bytes, struct(Opentelemetry.Proto.Common.V1.AnyValue))
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
              {[value: {:string_value, delimited}], rest}

            {2, _, bytes} ->
              {value, rest} = Protox.Decode.parse_bool(bytes)
              {[value: {:bool_value, value}], rest}

            {3, _, bytes} ->
              {value, rest} = Protox.Decode.parse_int64(bytes)
              {[value: {:int_value, value}], rest}

            {4, _, bytes} ->
              {value, rest} = Protox.Decode.parse_double(bytes)
              {[value: {:double_value, value}], rest}

            {5, _, bytes} ->
              {len, bytes} = Protox.Varint.decode(bytes)
              {delimited, rest} = Protox.Decode.parse_delimited(bytes, len)

              {[
                 case msg.value do
                   {:array_value, previous_value} ->
                     {:value,
                      {:array_value,
                       Protox.MergeMessage.merge(
                         previous_value,
                         Opentelemetry.Proto.Common.V1.ArrayValue.decode!(delimited)
                       )}}

                   _ ->
                     {:value,
                      {:array_value, Opentelemetry.Proto.Common.V1.ArrayValue.decode!(delimited)}}
                 end
               ], rest}

            {6, _, bytes} ->
              {len, bytes} = Protox.Varint.decode(bytes)
              {delimited, rest} = Protox.Decode.parse_delimited(bytes, len)

              {[
                 case msg.value do
                   {:kvlist_value, previous_value} ->
                     {:value,
                      {:kvlist_value,
                       Protox.MergeMessage.merge(
                         previous_value,
                         Opentelemetry.Proto.Common.V1.KeyValueList.decode!(delimited)
                       )}}

                   _ ->
                     {:value,
                      {:kvlist_value,
                       Opentelemetry.Proto.Common.V1.KeyValueList.decode!(delimited)}}
                 end
               ], rest}

            {7, _, bytes} ->
              {len, bytes} = Protox.Varint.decode(bytes)
              {delimited, rest} = Protox.Decode.parse_delimited(bytes, len)
              {[value: {:bytes_value, delimited}], rest}

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
        Opentelemetry.Proto.Common.V1.AnyValue,
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
        1 => {:string_value, {:oneof, :value}, :string},
        2 => {:bool_value, {:oneof, :value}, :bool},
        3 => {:int_value, {:oneof, :value}, :int64},
        4 => {:double_value, {:oneof, :value}, :double},
        5 =>
          {:array_value, {:oneof, :value}, {:message, Opentelemetry.Proto.Common.V1.ArrayValue}},
        6 =>
          {:kvlist_value, {:oneof, :value},
           {:message, Opentelemetry.Proto.Common.V1.KeyValueList}},
        7 => {:bytes_value, {:oneof, :value}, :bytes}
      }
    end

    @deprecated "Use fields_defs()/0 instead"
    @spec defs_by_name() :: %{
            required(atom) => {non_neg_integer, Protox.Types.kind(), Protox.Types.type()}
          }
    def defs_by_name() do
      %{
        array_value: {5, {:oneof, :value}, {:message, Opentelemetry.Proto.Common.V1.ArrayValue}},
        bool_value: {2, {:oneof, :value}, :bool},
        bytes_value: {7, {:oneof, :value}, :bytes},
        double_value: {4, {:oneof, :value}, :double},
        int_value: {3, {:oneof, :value}, :int64},
        kvlist_value:
          {6, {:oneof, :value}, {:message, Opentelemetry.Proto.Common.V1.KeyValueList}},
        string_value: {1, {:oneof, :value}, :string}
      }
    end
  )

  (
    @spec fields_defs() :: list(Protox.Field.t())
    def fields_defs() do
      [
        %{
          __struct__: Protox.Field,
          json_name: "stringValue",
          kind: {:oneof, :value},
          label: :optional,
          name: :string_value,
          tag: 1,
          type: :string
        },
        %{
          __struct__: Protox.Field,
          json_name: "boolValue",
          kind: {:oneof, :value},
          label: :optional,
          name: :bool_value,
          tag: 2,
          type: :bool
        },
        %{
          __struct__: Protox.Field,
          json_name: "intValue",
          kind: {:oneof, :value},
          label: :optional,
          name: :int_value,
          tag: 3,
          type: :int64
        },
        %{
          __struct__: Protox.Field,
          json_name: "doubleValue",
          kind: {:oneof, :value},
          label: :optional,
          name: :double_value,
          tag: 4,
          type: :double
        },
        %{
          __struct__: Protox.Field,
          json_name: "arrayValue",
          kind: {:oneof, :value},
          label: :optional,
          name: :array_value,
          tag: 5,
          type: {:message, Opentelemetry.Proto.Common.V1.ArrayValue}
        },
        %{
          __struct__: Protox.Field,
          json_name: "kvlistValue",
          kind: {:oneof, :value},
          label: :optional,
          name: :kvlist_value,
          tag: 6,
          type: {:message, Opentelemetry.Proto.Common.V1.KeyValueList}
        },
        %{
          __struct__: Protox.Field,
          json_name: "bytesValue",
          kind: {:oneof, :value},
          label: :optional,
          name: :bytes_value,
          tag: 7,
          type: :bytes
        }
      ]
    end

    [
      @spec(field_def(atom) :: {:ok, Protox.Field.t()} | {:error, :no_such_field}),
      (
        def field_def(:string_value) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "stringValue",
             kind: {:oneof, :value},
             label: :optional,
             name: :string_value,
             tag: 1,
             type: :string
           }}
        end

        def field_def("stringValue") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "stringValue",
             kind: {:oneof, :value},
             label: :optional,
             name: :string_value,
             tag: 1,
             type: :string
           }}
        end

        def field_def("string_value") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "stringValue",
             kind: {:oneof, :value},
             label: :optional,
             name: :string_value,
             tag: 1,
             type: :string
           }}
        end
      ),
      (
        def field_def(:bool_value) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "boolValue",
             kind: {:oneof, :value},
             label: :optional,
             name: :bool_value,
             tag: 2,
             type: :bool
           }}
        end

        def field_def("boolValue") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "boolValue",
             kind: {:oneof, :value},
             label: :optional,
             name: :bool_value,
             tag: 2,
             type: :bool
           }}
        end

        def field_def("bool_value") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "boolValue",
             kind: {:oneof, :value},
             label: :optional,
             name: :bool_value,
             tag: 2,
             type: :bool
           }}
        end
      ),
      (
        def field_def(:int_value) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "intValue",
             kind: {:oneof, :value},
             label: :optional,
             name: :int_value,
             tag: 3,
             type: :int64
           }}
        end

        def field_def("intValue") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "intValue",
             kind: {:oneof, :value},
             label: :optional,
             name: :int_value,
             tag: 3,
             type: :int64
           }}
        end

        def field_def("int_value") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "intValue",
             kind: {:oneof, :value},
             label: :optional,
             name: :int_value,
             tag: 3,
             type: :int64
           }}
        end
      ),
      (
        def field_def(:double_value) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "doubleValue",
             kind: {:oneof, :value},
             label: :optional,
             name: :double_value,
             tag: 4,
             type: :double
           }}
        end

        def field_def("doubleValue") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "doubleValue",
             kind: {:oneof, :value},
             label: :optional,
             name: :double_value,
             tag: 4,
             type: :double
           }}
        end

        def field_def("double_value") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "doubleValue",
             kind: {:oneof, :value},
             label: :optional,
             name: :double_value,
             tag: 4,
             type: :double
           }}
        end
      ),
      (
        def field_def(:array_value) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "arrayValue",
             kind: {:oneof, :value},
             label: :optional,
             name: :array_value,
             tag: 5,
             type: {:message, Opentelemetry.Proto.Common.V1.ArrayValue}
           }}
        end

        def field_def("arrayValue") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "arrayValue",
             kind: {:oneof, :value},
             label: :optional,
             name: :array_value,
             tag: 5,
             type: {:message, Opentelemetry.Proto.Common.V1.ArrayValue}
           }}
        end

        def field_def("array_value") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "arrayValue",
             kind: {:oneof, :value},
             label: :optional,
             name: :array_value,
             tag: 5,
             type: {:message, Opentelemetry.Proto.Common.V1.ArrayValue}
           }}
        end
      ),
      (
        def field_def(:kvlist_value) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "kvlistValue",
             kind: {:oneof, :value},
             label: :optional,
             name: :kvlist_value,
             tag: 6,
             type: {:message, Opentelemetry.Proto.Common.V1.KeyValueList}
           }}
        end

        def field_def("kvlistValue") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "kvlistValue",
             kind: {:oneof, :value},
             label: :optional,
             name: :kvlist_value,
             tag: 6,
             type: {:message, Opentelemetry.Proto.Common.V1.KeyValueList}
           }}
        end

        def field_def("kvlist_value") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "kvlistValue",
             kind: {:oneof, :value},
             label: :optional,
             name: :kvlist_value,
             tag: 6,
             type: {:message, Opentelemetry.Proto.Common.V1.KeyValueList}
           }}
        end
      ),
      (
        def field_def(:bytes_value) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "bytesValue",
             kind: {:oneof, :value},
             label: :optional,
             name: :bytes_value,
             tag: 7,
             type: :bytes
           }}
        end

        def field_def("bytesValue") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "bytesValue",
             kind: {:oneof, :value},
             label: :optional,
             name: :bytes_value,
             tag: 7,
             type: :bytes
           }}
        end

        def field_def("bytes_value") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "bytesValue",
             kind: {:oneof, :value},
             label: :optional,
             name: :bytes_value,
             tag: 7,
             type: :bytes
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
    def default(:string_value) do
      {:error, :no_default_value}
    end,
    def default(:bool_value) do
      {:error, :no_default_value}
    end,
    def default(:int_value) do
      {:error, :no_default_value}
    end,
    def default(:double_value) do
      {:error, :no_default_value}
    end,
    def default(:array_value) do
      {:error, :no_default_value}
    end,
    def default(:kvlist_value) do
      {:error, :no_default_value}
    end,
    def default(:bytes_value) do
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
        csharp_namespace: "OpenTelemetry.Proto.Common.V1",
        deprecated: nil,
        go_package: "go.opentelemetry.io/proto/otlp/common/v1",
        java_generate_equals_and_hash: nil,
        java_generic_services: nil,
        java_multiple_files: true,
        java_outer_classname: "CommonProto",
        java_package: "io.opentelemetry.proto.common.v1",
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
