defmodule PhrasesTest do
  use ExUnit.Case

  @test_word "elixir"
  @wlmi_answer 19.93858137067612

  test "get phrases" do
    {status, [resp | _]} = Word.Phrases.get_phrases(@test_word)
    wlmi = resp["wlmi"]

    assert status == :ok
    assert wlmi == @wlmi_answer
  end

  test "get phrases with parameters" do
    {status, [resp | _]} =
      Word.Phrases.get_phrases(@test_word, [:use_canonical, limit: 3, wlmi: 5])

    wlmi = resp["wlmi"]

    assert status == :ok
    assert wlmi == @wlmi_answer
  end

  test "reject phrases query with invalid params" do
    {status, msg} = Word.Phrases.get_phrases(@test_word, [:whoops])

    assert status == :error
    assert msg == "'whoops' not a valid parameter for the 'get_phrases' function"
  end
end
