defmodule EtymologiesTest do
  use ExUnit.Case

  @test_word "elixir"
  @api_key System.get_env("WORDNIK_API_KEY")

  test "get etymologies" do
    {status, resp} = Word.Etymologies.get_etymologies(@test_word, @api_key)
    [answer] = resp

    et =
      "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<ety>[F. <ets>√©lixir</ets>, Sp. <ets>elixir</ets>, Ar. <ets>eliksƒ´r</ets> the philosopher's stone, prob. from Gr. ÔøΩ dry, (hence probably) a dry powder; cf. Skr. <ets>kshƒÅ</ets> to burn.]</ety>\n"

    assert status == :ok
    assert answer == et
  end

  test "get etymologies with params" do
    {status, resp} = Word.Etymologies.get_etymologies(@test_word, @api_key, [:use_canonical])
    message = resp["message"]

    assert status == :ok
    assert message == "no canonical value found"
  end

  test "reject etymologies query with invalid params" do
    {status, msg} = Word.Etymologies.get_etymologies(@test_word, @api_key, [:whoops])

    assert status == :error
    assert msg == "'whoops' not a valid parameter for the 'get_etymologies' function"
  end
end
