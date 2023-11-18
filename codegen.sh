MIX_ENV=prod mix protox.generate \
--output-path=./lib/generated/ \
--include-path=./opentelemetry-proto \
--multiple-files \
./opentelemetry-proto/opentelemetry/proto/trace/v1/trace.proto \
./opentelemetry-proto/opentelemetry/proto/metrics/v1/metrics.proto \
./opentelemetry-proto/opentelemetry/proto/logs/v1/logs.proto \
./opentelemetry-proto/opentelemetry/proto/common/v1/common.proto \
./opentelemetry-proto/opentelemetry/proto/resource/v1/resource.proto \