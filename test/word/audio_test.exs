defmodule AudioTest do
  use ExUnit.Case

  @test_word "elixir"

  test "get audio" do
    {status, resp} = Wordnik.get_audio(@test_word)
    [details | _tail] = resp

    assert status == :ok
    assert details["audioType"] == "pronunciation"
  end

  test "get audio with params" do
    {status, resp} = Wordnik.get_audio(@test_word, %{use_canonical: true, limit: 2})
    [details | _tail] = resp

    assert status == :ok
    assert details["audioType"] == "pronunciation"
  end

  test "reject audio query with invalid params" do
    {status, msg} = Wordnik.get_audio(@test_word, %{whoops: true})

    assert status == :error
    assert msg == "'whoops' not a valid parameter for the 'get_audio' function"
  end
end
