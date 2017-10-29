defmodule EthBloom do
  use Bitwise

  def create(data) when is_binary(data) do
    data
    |> :keccakf1600.sha3_256
    |> bit_numbers
    |> Enum.reduce(0, fn(bit_number, bloom) ->
      bloom ||| (1 <<< bit_number)
    end)
  end

  def add(bloom, data) when is_binary(data) do
    data
    |> :keccakf1600.sha3_256
    |> bit_numbers
    |> Enum.reduce(bloom, fn(bit_number, bloom) ->
      bloom ||| (1 <<< bit_number)
    end)
  end

  def contains?(current_bloom, val) do
    bloom = create(val)

    (bloom && current_bloom) == bloom
  end

  defp bit_numbers(hash) do
    {result, _ } =
      1..3
      |> Enum.reduce({[], hash}, fn(_, acc) ->
        {bits, <<a1, a2, tail::bitstring>>} = acc
        new_bit = ((a1 <<< 8) + a2) &&& 2047

        {[new_bit|bits], tail}
      end)

    result
  end
end
