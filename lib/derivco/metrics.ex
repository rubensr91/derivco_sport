defmodule Derivco.Metrics do
  use Prometheus.Metric

  alias Prometheus.InvalidMetricArityError
  alias Prometheus.InvalidValueError
  alias Prometheus.Metric.Counter
  alias Prometheus.UnknownMetricError

  @type prometheus_error ::
          {:error, :invalid_metric_arity | :invalid_value | :unknown_metric}

  @type result :: {:ok, integer} | prometheus_error

  #######
  # API #
  #######

  @spec setup() :: {:ok, :ready}
  def setup, do: setup(nil)

  @spec setup(any) :: {:ok, :ready}
  def setup(_args) do
    Counter.declare(
      name: :git_version,
      help: "git",
      labels: [:git_version]
    )

    {:ok, :ready}
  end

  @spec add(atom, integer, keyword) :: result
  def add(key, quantity, opts \\ [labels: []]) do
    with :ok <- do_add(key, quantity, opts[:labels]) do
      do_get(key, opts[:labels])
    end
  end

  @spec inc(atom, keyword) :: result
  def inc(key, opts \\ [labels: []]), do: add(key, 1, opts)

  #################
  # Aux Functions #
  #################

  @spec do_add(atom, integer, keyword) :: :ok | prometheus_error
  defp do_add(key, quantity, labels) do
    Counter.inc([name: key, labels: labels], quantity)
    :ok
  rescue
    InvalidValueError -> {:error, :invalid_value}
    UnknownMetricError -> {:error, :unknown_metric}
    InvalidMetricArityError -> {:error, :invalid_metric_arity}
  end

  @spec do_get(atom, keyword) ::
          {:ok, integer} | {:error, :unknown_metric | :invalid_metric_arity}
  defp do_get(key, labels) do
    case Counter.value(name: key, labels: labels) do
      :undefined -> {:ok, 0}
      val -> {:ok, val}
    end
  rescue
    UnknownMetricError -> {:error, :unknown_metric}
    InvalidMetricArityError -> {:error, :invalid_metric_arity}
  end
end
