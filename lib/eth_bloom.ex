defmodule EthBloom do
  use Bitwise

  def create(data) when is_binary(data) do
    bloom(0, data)
  end

  def add(bloom_number, data) when is_binary(data) do
    bloom(bloom_number, data)
  end

  def contains?(current_bloom, val)
      when is_integer(curtent_bloom) and
      when is_binary(val) do
    bloom = create(val)

    (bloom &&& current_bloom) == bloom
  end

  defp bloom(number, data) do
    bits =
      data
      |> sha3_hash
      |> bit_numbers

    number |> add_bits(bits)
  end

  defp sha3_hash(data) do
    data |> :keccakf1600.sha3_256
  end

  defp add_bits(bloom_number, bits) do
    Enum.reduce(bloom_number, fn(bit_number, bloom) ->
      bloom ||| (1 <<< bit_number)
    end)
  end

  defp bit_numbers(hash) do
    {result, _} =
      1..3
      |> Enum.reduce({[], hash}, fn(_, acc) ->
        {bits, <<a1, a2, tail::bitstring>>} = acc
        new_bit = ((a1 <<< 8) + a2) &&& 2047

        {[new_bit|bits], tail}
      end)

    result
  end
end
