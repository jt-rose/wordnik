defmodule RelatedWordsTest do
  use ExUnit.Case

  @test_word "elixir"
  @api_key System.get_env("WORDNIK_API_KEY")

  test "get related words" do
    {status, resp} = Word.RelatedWords.get_related_words(@test_word, @api_key)
    [relationship | _tail] = resp

    assert status == :ok
    assert Map.has_key?(relationship, "relationshipType") == true
  end

  test "get related words with params" do
    {status, resp} =
      Word.RelatedWords.get_related_words(@test_word, @api_key, [
        :use_canonical,
        limit: 5,
        relationship_types: "synonym"
      ])

    [relationship | _tail] = resp

    assert status == :ok
    assert Map.has_key?(relationship, "relationshipType") == true
  end

  test "reject related_words query with invalid params" do
    {status, msg} = Word.RelatedWords.get_related_words(@test_word, @api_key, [:whoops])

    assert status == :error
    assert msg == "'whoops' not a valid parameter for the 'get_related_words' function"
  end
end
