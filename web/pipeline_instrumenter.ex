defmodule Derivco.PipelineInstrumenter do
  @moduledoc """
  Prometheus Plug Pipeline Instrumenter for Derivco
  """
  use Prometheus.PlugPipelineInstrumenter

  def label_value(:request_path, conn) do
    conn.request_path
  end
end
