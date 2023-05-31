defmodule HyphenationTest do
  use ExUnit.Case

  @test_word "elixir"

  test "get hyphenation" do
    {status, resp} = Wordnik.get_hyphenation(@test_word)
    [e, lix, ir] = resp

    assert status == :ok
    assert e["text"] == "e"
    assert lix["text"] == "lix"
    assert lix["type"] == "stress"
    assert ir["text"] == "ir"
  end

  test "get hyphenation with params" do
    {status, resp} =
      Wordnik.get_hyphenation(@test_word, %{
        use_canonical: true,
        limit: 5,
        source_dict: "webster"
      })

    [e, lix, ir] = resp

    assert status == :ok
    assert e["text"] == "e"
    assert lix["text"] == "lix"
    assert lix["type"] == "stress"
    assert ir["text"] == "ir"
  end

  test "reject hyphenation query with invalid params" do
    {status, msg} = Wordnik.get_hyphenation(@test_word, %{whoops: true})

    assert status == :error
    assert msg == "'whoops' not a valid parameter for the 'get_hyphenation' function"
  end
end
