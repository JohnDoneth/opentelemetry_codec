defmodule OpenTelemetryCodecTest do
  use ExUnit.Case
  doctest OpenTelemetryCodec

  @trace_data_example File.read!("../opentelemetry-codec/opentelemetry-proto/examples/trace.json")
  @logs_data_example File.read!("../opentelemetry-codec/opentelemetry-proto/examples/logs.json")
  @metrics_data_example File.read!(
                          "../opentelemetry-codec/opentelemetry-proto/examples/metrics.json"
                        )

  describe "decode_trace_data_json" do
    test "correctly decodes the example data" do
      assert {:ok,
              %Opentelemetry.Proto.Trace.V1.TracesData{
                resource_spans: [
                  %Opentelemetry.Proto.Trace.V1.ResourceSpans{
                    resource: %Opentelemetry.Proto.Resource.V1.Resource{
                      attributes: [
                        %Opentelemetry.Proto.Common.V1.KeyValue{
                          key: "service.name",
                          value: %Opentelemetry.Proto.Common.V1.AnyValue{
                            value: {:string_value, "my.service"}
                          }
                        }
                      ],
                      dropped_attributes_count: 0
                    },
                    scope_spans: [
                      %Opentelemetry.Proto.Trace.V1.ScopeSpans{
                        scope: %Opentelemetry.Proto.Common.V1.InstrumentationScope{
                          name: "my.library",
                          version: "1.0.0",
                          attributes: [
                            %Opentelemetry.Proto.Common.V1.KeyValue{
                              key: "my.scope.attribute",
                              value: %Opentelemetry.Proto.Common.V1.AnyValue{
                                value: {:string_value, "some scope attribute"}
                              }
                            }
                          ],
                          dropped_attributes_count: 0
                        },
                        spans: [
                          %Opentelemetry.Proto.Trace.V1.Span{
                            trace_id:
                              <<228, 31, 4, 20, 81, 123, 247, 205, 55, 243, 93, 55, 15, 110, 189,
                                7, 173, 247, 243, 93, 197, 11, 173, 2>>,
                            span_id: <<16, 65, 53, 244, 30, 196, 11, 112, 181, 7, 94, 248>>,
                            trace_state: "",
                            parent_span_id:
                              <<16, 65, 53, 244, 30, 196, 11, 112, 181, 7, 94, 247>>,
                            name: "I'm a server span",
                            kind: :SPAN_KIND_SERVER,
                            start_time_unix_nano: 1_544_712_660_000_000_000,
                            end_time_unix_nano: 1_544_712_661_000_000_000,
                            attributes: [
                              %Opentelemetry.Proto.Common.V1.KeyValue{
                                key: "my.span.attr",
                                value: %Opentelemetry.Proto.Common.V1.AnyValue{
                                  value: {:string_value, "some value"}
                                }
                              }
                            ],
                            dropped_attributes_count: 0,
                            events: [],
                            dropped_events_count: 0,
                            links: [],
                            dropped_links_count: 0,
                            status: nil
                          }
                        ],
                        schema_url: ""
                      }
                    ],
                    schema_url: ""
                  }
                ]
              }} = OpenTelemetryCodec.decode_trace_data_json(@trace_data_example)
    end
  end

  describe "decode_metrics_data_json" do
    test "correctly decodes the example data" do
      assert {:ok,
              %Opentelemetry.Proto.Metrics.V1.MetricsData{
                resource_metrics: [
                  %Opentelemetry.Proto.Metrics.V1.ResourceMetrics{
                    resource: %Opentelemetry.Proto.Resource.V1.Resource{
                      attributes: [
                        %Opentelemetry.Proto.Common.V1.KeyValue{
                          key: "service.name",
                          value: %Opentelemetry.Proto.Common.V1.AnyValue{
                            value: {:string_value, "my.service"}
                          }
                        }
                      ],
                      dropped_attributes_count: 0
                    },
                    scope_metrics: [
                      %Opentelemetry.Proto.Metrics.V1.ScopeMetrics{
                        scope: %Opentelemetry.Proto.Common.V1.InstrumentationScope{
                          name: "my.library",
                          version: "1.0.0",
                          attributes: [
                            %Opentelemetry.Proto.Common.V1.KeyValue{
                              key: "my.scope.attribute",
                              value: %Opentelemetry.Proto.Common.V1.AnyValue{
                                value: {:string_value, "some scope attribute"}
                              }
                            }
                          ],
                          dropped_attributes_count: 0
                        },
                        metrics: [
                          %Opentelemetry.Proto.Metrics.V1.Metric{
                            name: "my.counter",
                            description: "I'm a Counter",
                            unit: "1",
                            data:
                              {:sum,
                               %Opentelemetry.Proto.Metrics.V1.Sum{
                                 data_points: [
                                   %Opentelemetry.Proto.Metrics.V1.NumberDataPoint{
                                     start_time_unix_nano: 1_544_712_660_300_000_000,
                                     time_unix_nano: 1_544_712_660_300_000_000,
                                     value: {:as_double, 5},
                                     exemplars: [],
                                     attributes: [
                                       %Opentelemetry.Proto.Common.V1.KeyValue{
                                         key: "my.counter.attr",
                                         value: %Opentelemetry.Proto.Common.V1.AnyValue{
                                           value: {:string_value, "some value"}
                                         }
                                       }
                                     ],
                                     flags: 0
                                   }
                                 ],
                                 aggregation_temporality: :AGGREGATION_TEMPORALITY_DELTA,
                                 is_monotonic: true
                               }}
                          },
                          %Opentelemetry.Proto.Metrics.V1.Metric{
                            name: "my.gauge",
                            description: "I'm a Gauge",
                            unit: "1",
                            data:
                              {:gauge,
                               %Opentelemetry.Proto.Metrics.V1.Gauge{
                                 data_points: [
                                   %Opentelemetry.Proto.Metrics.V1.NumberDataPoint{
                                     start_time_unix_nano: 0,
                                     time_unix_nano: 1_544_712_660_300_000_000,
                                     value: {:as_double, 10},
                                     exemplars: [],
                                     attributes: [
                                       %Opentelemetry.Proto.Common.V1.KeyValue{
                                         key: "my.gauge.attr",
                                         value: %Opentelemetry.Proto.Common.V1.AnyValue{
                                           value: {:string_value, "some value"}
                                         }
                                       }
                                     ],
                                     flags: 0
                                   }
                                 ]
                               }}
                          },
                          %Opentelemetry.Proto.Metrics.V1.Metric{
                            name: "my.histogram",
                            description: "I'm a Histogram",
                            unit: "1",
                            data:
                              {:histogram,
                               %Opentelemetry.Proto.Metrics.V1.Histogram{
                                 data_points: [
                                   %Opentelemetry.Proto.Metrics.V1.HistogramDataPoint{
                                     start_time_unix_nano: 1_544_712_660_300_000_000,
                                     time_unix_nano: 1_544_712_660_300_000_000,
                                     count: 3,
                                     sum: 3,
                                     bucket_counts: [1, 1, 1],
                                     explicit_bounds: [1],
                                     exemplars: [],
                                     attributes: [
                                       %Opentelemetry.Proto.Common.V1.KeyValue{
                                         key: "my.histogram.attr",
                                         value: %Opentelemetry.Proto.Common.V1.AnyValue{
                                           value: {:string_value, "some value"}
                                         }
                                       }
                                     ],
                                     flags: 0,
                                     min: 1,
                                     max: 1
                                   }
                                 ],
                                 aggregation_temporality: :AGGREGATION_TEMPORALITY_DELTA
                               }}
                          }
                        ],
                        schema_url: ""
                      }
                    ],
                    schema_url: ""
                  }
                ]
              }} = OpenTelemetryCodec.decode_metrics_data_json(@metrics_data_example)
    end
  end

  describe "decode_logs_data_json" do
    test "correctly decodes the example data" do
      assert {:ok,
              %Opentelemetry.Proto.Logs.V1.LogsData{
                resource_logs: [
                  %Opentelemetry.Proto.Logs.V1.ResourceLogs{
                    resource: %Opentelemetry.Proto.Resource.V1.Resource{
                      attributes: [
                        %Opentelemetry.Proto.Common.V1.KeyValue{
                          key: "service.name",
                          value: %Opentelemetry.Proto.Common.V1.AnyValue{
                            value: {:string_value, "my.service"}
                          }
                        }
                      ],
                      dropped_attributes_count: 0
                    },
                    scope_logs: [
                      %Opentelemetry.Proto.Logs.V1.ScopeLogs{
                        scope: %Opentelemetry.Proto.Common.V1.InstrumentationScope{
                          name: "my.library",
                          version: "1.0.0",
                          attributes: [
                            %Opentelemetry.Proto.Common.V1.KeyValue{
                              key: "my.scope.attribute",
                              value: %Opentelemetry.Proto.Common.V1.AnyValue{
                                value: {:string_value, "some scope attribute"}
                              }
                            }
                          ],
                          dropped_attributes_count: 0
                        },
                        log_records: [
                          %Opentelemetry.Proto.Logs.V1.LogRecord{
                            time_unix_nano: 1_544_712_660_300_000_000,
                            severity_number: :SEVERITY_NUMBER_UNSPECIFIED,
                            severity_text: "Information",
                            body: %Opentelemetry.Proto.Common.V1.AnyValue{
                              value: {:string_value, "Example log record"}
                            },
                            attributes: [
                              %Opentelemetry.Proto.Common.V1.KeyValue{
                                key: "string.attribute",
                                value: %Opentelemetry.Proto.Common.V1.AnyValue{
                                  value: {:string_value, "some string"}
                                }
                              },
                              %Opentelemetry.Proto.Common.V1.KeyValue{
                                key: "boolean.attribute",
                                value: %Opentelemetry.Proto.Common.V1.AnyValue{
                                  value: {:bool_value, true}
                                }
                              },
                              %Opentelemetry.Proto.Common.V1.KeyValue{
                                key: "int.attribute",
                                value: %Opentelemetry.Proto.Common.V1.AnyValue{
                                  value: {:int_value, 10}
                                }
                              },
                              %Opentelemetry.Proto.Common.V1.KeyValue{
                                key: "double.attribute",
                                value: %Opentelemetry.Proto.Common.V1.AnyValue{
                                  value: {:double_value, 637.704}
                                }
                              },
                              %Opentelemetry.Proto.Common.V1.KeyValue{
                                key: "array.attribute",
                                value: %Opentelemetry.Proto.Common.V1.AnyValue{
                                  value:
                                    {:array_value,
                                     %Opentelemetry.Proto.Common.V1.ArrayValue{
                                       values: [
                                         %Opentelemetry.Proto.Common.V1.AnyValue{
                                           value: {:string_value, "many"}
                                         },
                                         %Opentelemetry.Proto.Common.V1.AnyValue{
                                           value: {:string_value, "values"}
                                         }
                                       ]
                                     }}
                                }
                              },
                              %Opentelemetry.Proto.Common.V1.KeyValue{
                                key: "map.attribute",
                                value: %Opentelemetry.Proto.Common.V1.AnyValue{
                                  value:
                                    {:kvlist_value,
                                     %Opentelemetry.Proto.Common.V1.KeyValueList{
                                       values: [
                                         %Opentelemetry.Proto.Common.V1.KeyValue{
                                           key: "some.map.key",
                                           value: %Opentelemetry.Proto.Common.V1.AnyValue{
                                             value: {:string_value, "some value"}
                                           }
                                         }
                                       ]
                                     }}
                                }
                              }
                            ],
                            dropped_attributes_count: 0,
                            flags: 0,
                            trace_id:
                              <<228, 31, 4, 20, 81, 123, 247, 205, 55, 243, 93, 55, 15, 110, 189,
                                7, 173, 247, 243, 93, 197, 11, 173, 2>>,
                            span_id: <<16, 65, 53, 244, 30, 196, 11, 112, 181, 7, 94, 248>>,
                            observed_time_unix_nano: 1_544_712_660_300_000_000
                          }
                        ],
                        schema_url: ""
                      }
                    ],
                    schema_url: ""
                  }
                ]
              }} = OpenTelemetryCodec.decode_logs_data_json(@logs_data_example)
    end
  end
end
