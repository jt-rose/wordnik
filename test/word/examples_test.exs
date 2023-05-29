defmodule ExamplesTest do
  use ExUnit.Case

  @test_word "elixir"
  @example "In the eternal quest for a fountain of youth, no elixir is beyond the realm of consideration."

  test "get examples" do
    {status, resp} = Word.Examples.get_examples(@test_word)

    found = Enum.find(resp["examples"], fn item -> item["text"] == @example end)

    assert status == :ok
    assert found != nil
  end

  test "get examples with params" do
    {status, resp} =
      Word.Examples.get_examples(@test_word, [
        :use_canonical,
        :include_duplicates,
        limit: 3,
        skip: 0
      ])

    found = Enum.find(resp["examples"], fn item -> item["text"] == @example end)

    assert status == :ok
    assert found != nil
  end

  test "reject examples query with invalid params" do
    {status, msg} = Word.Examples.get_examples(@test_word, [:whoops])

    assert status == :error
    assert msg == "'whoops' not a valid parameter for the 'get_examples' function"
  end
end
