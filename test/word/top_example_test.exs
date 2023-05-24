defmodule TopExampleTest do
  use ExUnit.Case

  @test_word "elixir"
  @example "In the eternal quest for a fountain of youth, no elixir is beyond the realm of consideration."
  @api_key System.get_env("WORDNIK_API_KEY")

  test "get top example" do
    {status, resp} = Word.TopExample.get_top_example(@test_word, @api_key)

    assert status == :ok
    assert resp["exampleId"] == 944_083_198
    assert resp["text"] == @example
  end

  test "get top example with parameters" do
    {status, resp} = Word.TopExample.get_top_example(@test_word, @api_key, [:use_canonical])

    assert status == :ok
    assert resp["exampleId"] == 944_083_198
    assert resp["text"] == @example
  end

  test "reject top_example query with invalid params" do
    {status, msg} = Word.TopExample.get_top_example(@test_word, @api_key, [:whoops])

    assert status == :error
    assert msg == "'whoops' not a valid parameter for the 'get_top_example' function"
  end
end
