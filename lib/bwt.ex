defmodule BWT do
  import Enum, except: [slice: 2]
  import String, except: [at: 2, to_char_list: 1]

  def rotate(str, index) do
    slice(str, index+1..-1) <> slice(str, 0..index)
  end

  def sorted_rotations(str) do
    sort(map(0..String.length(str)-1, fn (i) ->
      rotate(str, i)
    end))
  end

  def last_column(rs) do
    join(map(rs, fn (r) ->
      String.slice(r, -1..-1)
    end))
  end

  def encode(str) do
    rs = sorted_rotations(str)
    %{:encoded => last_column(rs), :index => find_index(rs, fn(x) -> x == str end)}
  end

  def decode(encoded) do
    length = String.length(encoded.encoded)
    length_squared = length * length
    chars = List.duplicate((encoded.encoded), length) |> Enum.join
    indices = Stream.cycle(0..String.length(encoded.encoded) - 1) |> take(length_squared)
    build_permutations(length, chars, indices, List.duplicate("", length)) |> Enum.at(encoded.index)
  end

  def build_permutations(_, _, [], ps) do
    ps
  end

  def build_permutations(length, chars, indices, ps) do
    build_permutations(length, slice(chars, 1..-1), drop(indices, 1), 
      add_to_permutation(length, first(chars), List.first(indices), ps))
  end

  def add_to_permutation(length, ch, i, ps) do
    if i == length - 1 do
      sort(List.replace_at(ps, i, ch <> Enum.at(ps, i)))
    else
      List.replace_at(ps, i, ch <> Enum.at(ps, i))
    end
  end
end
