defmodule RelatedWordsTest do
  use ExUnit.Case

  @test_word "elixir"

  test "get related words" do
    {status, resp} = Word.RelatedWords.get_related_words(@test_word)
    [relationship | _tail] = resp

    assert status == :ok
    assert Map.has_key?(relationship, "relationshipType") == true
  end

  test "get related words with params" do
    {status, resp} =
      Word.RelatedWords.get_related_words(@test_word, %{
        use_canonical: true,
        limit: 5,
        relationship_types: "synonym"
      })

    [relationship | _tail] = resp

    assert status == :ok
    assert Map.has_key?(relationship, "relationshipType") == true
  end

  test "reject related_words query with invalid params" do
    {status, msg} = Word.RelatedWords.get_related_words(@test_word, %{whoops: true})

    assert status == :error
    assert msg == "'whoops' not a valid parameter for the 'get_related_words' function"
  end
end
