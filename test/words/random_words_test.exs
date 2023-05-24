defmodule Words.RandomWordsTest do
  use ExUnit.Case

  @api_key System.get_env("WORDNIK_API_KEY")

  test "get random words" do
    {status, [resp | _]} = Words.RandomWords.get_random_words(@api_key)

    assert status == :ok
    assert Map.has_key?(resp, "id") == true
    assert Map.has_key?(resp, "word") == true
  end

  test "get random words with parameters" do
    {status, [resp | _]} =
      Words.RandomWords.get_random_words(@api_key, [
        :has_dictionary_def,
        include_part_of_speech: "noun",
        exclude_part_of_speech: "verb",
        min_corpus_count: 1,
        max_corpus_count: 100,
        min_dictionary_count: 1,
        max_dictionary_count: 100,
        min_length: 1,
        max_length: 100,
        limit: 5,
        sort_by: "alpha",
        sort_order: "asc"
      ])

    assert status == :ok
    assert Map.has_key?(resp, "id") == true
    assert Map.has_key?(resp, "word") == true
  end

  test "reject random words query with invalid params" do
    {status, msg} = Words.RandomWords.get_random_words(@api_key, [:whoops])

    assert status == :error
    assert msg == "'whoops' not a valid parameter for the 'get_random_words' function"
  end
end
