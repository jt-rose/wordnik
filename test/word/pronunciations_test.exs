defmodule PronunciationsTest do
  use ExUnit.Case

  @test_word "elixir"
  @api_key System.get_env("WORDNIK_API_KEY")

  test "get pronunciations" do
    {status, resp} = Word.Pronunciations.get_pronunciations(@test_word, @api_key)
    [pron | _tail] = resp

    assert status == :ok
    assert Map.has_key?(pron, "textProns") == true
  end

  test "get pronunciations with parameters" do
    {status, resp} =
      Word.Pronunciations.get_pronunciations(@test_word, @api_key, [
        :use_canonical,
        limit: 5,
        type_format: "ahd-5",
        source_dict: "ahd-5"
      ])

    [pron | _tail] = resp

    assert status == :ok
    assert Map.has_key?(pron, "textProns") == true
  end

  test "reject prnonuciationa query with invalid params" do
    {status, msg} = Word.Pronunciations.get_pronunciations(@test_word, @api_key, [:whoops])

    assert status == :error
    assert msg == "'whoops' not a valid parameter for the 'get_pronunciations' function"
  end
end
