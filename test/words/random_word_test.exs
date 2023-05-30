defmodule Words.RandomWordTest do
  use ExUnit.Case

  test "get random word" do
    {status, resp} = Words.RandomWord.get_random_word()

    assert status == :ok
    assert Map.has_key?(resp, "id") == true
    assert Map.has_key?(resp, "word") == true
  end

  test "get random word with parameters" do
    {status, resp} =
      Words.RandomWord.get_random_word(%{
        has_dictionary_def: true,
        include_part_of_speech: "noun",
        exclude_part_of_speech: "verb",
        min_corpus_count: 1,
        max_corpus_count: 100,
        min_dictionary_count: 1,
        max_dictionary_count: 100,
        min_length: 1,
        max_length: 100
      })

    assert status == :ok
    assert Map.has_key?(resp, "id") == true
    assert Map.has_key?(resp, "word") == true
  end

  test "reject random word query with invalid params" do
    {status, msg} = Words.RandomWord.get_random_word(%{whoops: true})

    assert status == :error
    assert msg == "'whoops' not a valid parameter for the 'get_random_word' function"
  end
end
