defmodule PronunciationsTest do
  use ExUnit.Case

  @test_word "elixir"

  test "get pronunciations" do
    {status, resp} = Word.Pronunciations.get_pronunciations(@test_word)
    [pron | _tail] = resp

    assert status == :ok
    assert Map.has_key?(pron, "textProns") == true
  end

  test "get pronunciations with parameters" do
    {status, resp} =
      Word.Pronunciations.get_pronunciations(@test_word, %{
        use_canonical: true,
        limit: 5,
        type_format: "ahd-5",
        source_dict: "ahd-5"
      })

    [pron | _tail] = resp

    assert status == :ok
    assert Map.has_key?(pron, "textProns") == true
  end

  test "reject prnonuciationa query with invalid params" do
    {status, msg} = Word.Pronunciations.get_pronunciations(@test_word, %{whoops: true})

    assert status == :error
    assert msg == "'whoops' not a valid parameter for the 'get_pronunciations' function"
  end
end
