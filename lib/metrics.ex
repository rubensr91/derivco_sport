defmodule DerivcoSportWeb.Metrics do

  use Prometheus.Metric

  alias Prometheus.InvalidMetricArityError
  alias Prometheus.InvalidValueError
  alias Prometheus.Metric.Counter
  alias Prometheus.UnknownMetricError

  @type prometheus_error ::
  {:error, :invalid_metric_arity | :invalid_value | :unknown_metric }

  @type result :: {:ok, integer} | prometheus_error

  #######
  # API #
  #######

  @spec setup() :: {:ok, :ready}
  def setup, do: setup(nil)

  @spec setup(any) :: {:ok, :ready}
  def setup(_args) do

    Counter.declare(
      name: :version,
      help: "version metrics",
      labels: [:version]
    )

    {:ok, :ready}
  end

  @spec add(atom, integer, keyword) ::result
  def add(key, quantity, opts \\ [labels: []]) do
    with :ok <-  do_add(key, quantity, opts[:labels]) do
      do_get(key, opts[:labels])
    end
  end

  @spec inc(atom, keyword) :: result
  def inc(key, opts \\ [labels: []]), do: add(key, 1, opts)
  
  @spec reset(atom, keyword) :: result
  def reset(key, opts \\ [labels: []]), do: do_reset(key, opts[:labels])

  @spec get(atom, keyword) :: result
  def get(key, opts \\ [labels: []]), do: do_get(key, opts[:labels])

  def gauge_inc(spec, value \\ 1), do: Gauge.inc(spec, value)

  def gauge_dec(spec, value \\ 1), do: Gauge.dec(spec, value)

  def histogram_observe(spec, value), do: Histogram.observe(spec, value)

  #################
  # Aux Functions #
  #################

  @spec do_add(atom, integer, keyword) :: :ok | prometheus_error
  defp do_add(key, quantity, labels) do
    Counter.inc([name: key, labels: labels], quantity)
    :ok
  rescue
    InvalidValueError        ->  {:error, :invalid_value}
    UnknownMetricError       ->  {:error, :unknown_metric}
    InvalidMetricArityError  ->  {:error, :invalid_metric_arity}
  end

  @spec do_get(atom, keyword) ::
    {:ok, integer} | {:error, :unknown_metric | :invalid_metric_arity}
  defp do_get(key, labels) do
    case Counter.value(name: key, labels: labels) do
      :undefined  -> {:ok, 0}
      val         -> {:ok, val}
    end
  rescue
    UnknownMetricError       ->  {:error, :unknown_metric}
    InvalidMetricArityError  ->  {:error, :invalid_metric_arity}
  end

  @spec do_reset(atom, keyword) ::
    {:ok, 0} | {:error, :unknown_metric | :invalid_metric_arity}
  defp do_reset(key, labels) do
    Counter.reset(name: key, labels: labels)
    {:ok, 0}
  rescue
    UnknownMetricError       ->  {:error, :unknown_metric}
    InvalidMetricArityError  ->  {:error, :invalid_metric_arity}
  end

end
