defmodule ScrabbleScoreTest do
  use ExUnit.Case

  @test_word "elixir"
  @api_key System.get_env("WORDNIK_API_KEY")

  test "get scrabble score" do
    {status, resp} = Word.ScrabbleScore.get_scrabble_score(@test_word, @api_key)

    assert status == :ok
    assert resp["value"] == 13
  end
end
