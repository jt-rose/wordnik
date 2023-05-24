defmodule HyphenationTest do
  use ExUnit.Case

  @test_word "elixir"
  @api_key System.get_env("WORDNIK_API_KEY")

  test "get hyphenation" do
    {status, resp} = Word.Hyphenation.get_hyphenation(@test_word, @api_key)
    [e, lix, ir] = resp

    assert status == :ok
    assert e["text"] == "e"
    assert lix["text"] == "lix"
    assert lix["type"] == "stress"
    assert ir["text"] == "ir"
  end

  test "get hyphenation with params" do
    {status, resp} =
      Word.Hyphenation.get_hyphenation(@test_word, @api_key, [
        :use_canonical,
        limit: 5,
        source_dict: "webster"
      ])

    [e, lix, ir] = resp

    assert status == :ok
    assert e["text"] == "e"
    assert lix["text"] == "lix"
    assert lix["type"] == "stress"
    assert ir["text"] == "ir"
  end

  test "reject hyphenation query with invalid params" do
    {status, msg} = Word.Hyphenation.get_hyphenation(@test_word, @api_key, [:whoops])

    assert status == :error
    assert msg == "'whoops' not a valid parameter for the 'get_hyphenation' function"
  end
end
