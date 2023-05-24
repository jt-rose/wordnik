defmodule FrequencyTest do
  use ExUnit.Case

  @test_word "elixir"
  @api_key System.get_env("WORDNIK_API_KEY")

  test "get frequency" do
    {status, resp} = Word.Frequency.get_frequency(@test_word, @api_key)
    [record | _tail] = resp["frequency"]

    assert status == :ok
    assert record["year"] == "1801"
    assert record["count"] == 9
  end

  test "get frequency with params" do
    {status, resp} =
      Word.Frequency.get_frequency(@test_word, @api_key, [
        :use_canonical,
        start_year: 1800,
        end_year: 2000
      ])

    [record | _tail] = resp["frequency"]

    assert status == :ok
    assert record["year"] == "1801"
    assert record["count"] == 9
  end

  test "reject frequency query with invalid params" do
    {status, msg} = Word.Frequency.get_frequency(@test_word, @api_key, [:whoops])

    assert status == :error
    assert msg == "'whoops' not a valid parameter for the 'get_frequency' function"
  end
end
