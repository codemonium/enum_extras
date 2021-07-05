defmodule EnumExtras do
  @moduledoc """
  Provides additional utility functions for working with enumerables.
  """

  @type t :: Enumerable.t()

  @doc """
  Calculates the average of the elements in the `enumerable`.

  It should return `nil` if the `enumerable` is empty.

  FIXME: Susceptible to floating-point errors.
  """
  @spec average(t) :: nil | integer
  def average([]), do: nil

  def average(list) when is_list(list) do
    Enum.sum(list) / Enum.count(list)
  end

  @doc """
  Calculates the weighted average of the elements in the `enumerable`.

  It should return `nil` if the `enumerable` is empty or the weights sum to zero.

  FIXME: Susceptible to floating-point errors.

  TODO: Handle case when number of weights differs from number of elements in list.
  """
  @spec weighted_average(t, t) :: nil | integer
  def weighted_average([], _weights), do: nil

  def weighted_average(list, weights) when is_list(list) and is_list(weights) do
    case Enum.sum(weights) do
      0 ->
        nil

      sum ->
        total =
          Enum.zip(list, weights)
          |> Enum.reduce(0, fn {element, weight}, acc -> acc + element * weight end)

        total / sum
    end
  end
end
