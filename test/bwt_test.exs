defmodule BWTTest do
  use ExUnit.Case

  test "rotates a string" do
    assert BWT.rotate("banana", 0) == "ananab"
  end

  test "generates and sorts rotations" do
    assert Enum.fetch!(BWT.sorted_rotations("banana"), 0) == "abanan"
  end

  test "it encodes correctly" do
    assert BWT.encode("banana") == %{:encoded => "nnbaaa", :index => 3}
  end

  test "it decodes correctly" do
    assert BWT.decode(%{:encoded => "nnbaaa", :index => 3 }) == "banana"
    #BWT.decode(%{:encoded => "nnbaaa", :index => 3 })
  end
end
