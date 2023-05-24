defmodule AudioTest do
  use ExUnit.Case

  @test_word "elixir"
  @api_key System.get_env("WORDNIK_API_KEY")

  test "get audio" do
    {status, resp} = Word.Audio.get_audio(@test_word, @api_key)
    [details | _tail] = resp

    assert status == :ok
    assert details["audioType"] == "pronunciation"
  end

  test "get audio with params" do
    {status, resp} = Word.Audio.get_audio(@test_word, @api_key, [:use_canonical, limit: 2])
    [details | _tail] = resp

    assert status == :ok
    assert details["audioType"] == "pronunciation"
  end

  test "reject audio query with invalid params" do
    {status, msg} = Word.Audio.get_audio(@test_word, @api_key, [:whoops])

    assert status == :error
    assert msg == "'whoops' not a valid parameter for the 'get_audio' function"
  end
end
