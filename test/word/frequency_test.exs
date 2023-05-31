defmodule FrequencyTest do
  use ExUnit.Case

  @test_word "elixir"

  test "get frequency" do
    {status, resp} = Wordnik.get_frequency(@test_word)
    [record | _tail] = resp["frequency"]

    assert status == :ok
    assert record["year"] == "1801"
    assert record["count"] == 9
  end

  test "get frequency with params" do
    {status, resp} =
      Wordnik.get_frequency(@test_word, %{
        use_canonical: true,
        start_year: 1800,
        end_year: 2000
      })

    [record | _tail] = resp["frequency"]

    assert status == :ok
    assert record["year"] == "1801"
    assert record["count"] == 9
  end

  test "reject frequency query with invalid params" do
    {status, msg} = Wordnik.get_frequency(@test_word, %{whoops: true})

    assert status == :error
    assert msg == "'whoops' not a valid parameter for the 'get_frequency' function"
  end
end
