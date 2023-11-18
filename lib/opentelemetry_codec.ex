defmodule OpenTelemetryCodec do
  @moduledoc """
  OpenTelemetryCodec allows for parsing OpenTelemetry trace, metrics and log
  data from JSON or Protobuf encoded data.
  """
  use Protox,
    paths: [
      "C:/Users/John/projects/opentelemetry-codec/opentelemetry-proto"
    ],
    files: [
      "opentelemetry-proto/opentelemetry/proto/trace/v1/trace.proto",
      "opentelemetry-proto/opentelemetry/proto/metrics/v1/metrics.proto",
      "opentelemetry-proto/opentelemetry/proto/logs/v1/logs.proto",
      "opentelemetry-proto/opentelemetry/proto/common/v1/common.proto",
      "opentelemetry-proto/opentelemetry/proto/resource/v1/resource.proto"
    ]

  # --------------
  # -- Decoding --
  # --------------

  @spec decode_trace_data_json(binary()) :: {:error, any()} | {:ok, struct()}
  def decode_trace_data_json(data) do
    Protox.json_decode(data, Opentelemetry.Proto.Trace.V1.TracesData)
  end

  @spec decode_metrics_data_json(binary()) :: {:error, any()} | {:ok, struct()}
  def decode_metrics_data_json(data) do
    Protox.json_decode(data, Opentelemetry.Proto.Metrics.V1.MetricsData)
  end

  @spec decode_logs_data_json(binary()) :: {:error, any()} | {:ok, struct()}
  def decode_logs_data_json(data) do
    Protox.json_decode(data, Opentelemetry.Proto.Logs.V1.LogsData)
  end

  @spec decode_trace_data_protobuf(binary()) :: {:error, any()} | {:ok, struct()}
  def decode_trace_data_protobuf(data) do
    Protox.decode(data, Opentelemetry.Proto.Trace.V1.TracesData)
  end

  @spec decode_metrics_data_protobuf(binary()) :: {:error, any()} | {:ok, struct()}
  def decode_metrics_data_protobuf(data) do
    Protox.decode(data, Opentelemetry.Proto.Metrics.V1.MetricsData)
  end

  @spec decode_logs_data_protobuf(binary()) :: {:error, any()} | {:ok, struct()}
  def decode_logs_data_protobuf(data) do
    Protox.decode(data, Opentelemetry.Proto.Logs.V1.LogsData)
  end

  # --------------
  # -- Encoding --
  # --------------

  @spec decode_trace_data_json(struct()) :: {:error, any()} | {:ok, binary()}
  def encode_trace_data_json(data), do: Protox.json_encode(data)

  @spec encode_metrics_data_json(struct()) :: {:error, any()} | {:ok, binary()}
  def encode_metrics_data_json(data), do: Protox.json_encode(data)

  @spec encode_logs_data_json(struct()) :: {:error, any()} | {:ok, binary()}
  def encode_logs_data_json(data), do: Protox.json_encode(data)

  @spec encode_trace_data_protobuf(struct()) :: {:error, any()} | {:ok, binary()}
  def encode_trace_data_protobuf(data), do: Protox.encode(data)

  @spec encode_metrics_data_protobuf(struct()) :: {:error, any()} | {:ok, binary()}
  def encode_metrics_data_protobuf(data), do: Protox.encode(data)

  @spec encode_logs_data_protobuf(struct()) :: {:error, any()} | {:ok, binary()}
  def encode_logs_data_protobuf(data), do: Protox.encode(data)
end
