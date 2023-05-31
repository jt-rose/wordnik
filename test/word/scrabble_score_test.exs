defmodule ScrabbleScoreTest do
  use ExUnit.Case

  @test_word "elixir"

  test "get scrabble score" do
    {status, resp} = Wordnik.get_scrabble_score(@test_word)

    assert status == :ok
    assert resp["value"] == 13
  end
end
