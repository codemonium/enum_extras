defmodule EnumExtras do
  @moduledoc """
  Provides additional utility functions for working with enumerables.
  """

  @type t :: Enumerable.t()

  @type element :: any

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

  @doc """
  Partitions the elements of the `enumerable` according to the pairwise comparator.

  ## Examples

      iex> EnumExtras.chunk_by_pairwise([1, 2, 3, 4, 1, 2, 3, 1, 2, 1], fn a, b -> a <= b end)
      [[1, 2, 3, 4], [1, 2, 3], [1, 2], [1]]
  """
  @spec chunk_by_pairwise(t, (element, element -> boolean)) :: t
  def chunk_by_pairwise([], _comparator), do: []
  def chunk_by_pairwise([value], _comparator), do: [[value]]

  def chunk_by_pairwise(values, comparator) do
    values
    |> Enum.reverse()
    |> Enum.chunk_every(2, 1)
    |> Enum.reduce([[]], fn
      [value], [head | tail] ->
        [[value | head] | tail]

      [left_value, right_value], [head | tail] ->
        acc = [[left_value | head] | tail]
        # The arguments in the comparator are reversed because the given list is reversed above.
        case comparator.(right_value, left_value) do
          true -> acc
          false -> [[]] ++ acc
        end
    end)
  end
end
