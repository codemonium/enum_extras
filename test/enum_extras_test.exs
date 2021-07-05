defmodule EnumExtrasTest do
  use ExUnit.Case
  doctest EnumExtras

  test "when input is empty, average does not exist" do
    assert EnumExtras.average([]) == nil
  end

  test "average" do
    assert EnumExtras.average([1, 2, 3, 4]) == 2.5
  end

  test "when input is empty, weighted average does not exist" do
    assert EnumExtras.weighted_average([], [1, 2, 3]) == nil
  end

  test "when weights sum to zero, weighted average does not exist" do
    assert EnumExtras.weighted_average([1, 2, 3], [-1, -2, 3]) == nil
  end

  test "weighted average" do
    assert EnumExtras.weighted_average([1, 2, 3, 4], [4, 3, 2, 1]) == 2
  end
end
