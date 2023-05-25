defmodule DefinitionsTest do
  use ExUnit.Case

  @test_word "elixir"
  @definition "A sweetened aromatic solution of alcohol and water, serving as a vehicle for medicine."
  @api_key System.get_env("WORDNIK_API_KEY")

  test "get definitions" do
    {status, resp} = Word.Definitions.get_definitions(@test_word, @api_key)

    found = Enum.find(resp, fn item -> item["text"] == @definition end)
    assert status == :ok
    assert found != nil
  end

  test "get definitions with params" do
    {status, resp} =
      Word.Definitions.get_definitions(@test_word, @api_key, [
        :use_canonical,
        :include_related,
        :include_tags,
        part_of_speech: "noun",
        source_dictionaries: "ahd-5,webster"
      ])

    found = Enum.find(resp, fn item -> item["text"] == @definition end)
    assert status == :ok
    assert found != nil
  end

  test "reject definitions query with invalid params" do
    {status, msg} = Word.Definitions.get_definitions(@test_word, @api_key, [:whoops])
    assert status == :error
    assert msg == "'whoops' not a valid parameter for the 'get_definitions' function"
  end

  test "reject definitions query with invalid list of source dictionaries" do
    {status, msg} =
      Word.Definitions.get_definitions(@test_word, @api_key,
        source_dictionaries: "adh-5,webster,whoops"
      )

    assert status == :error

    assert msg ==
             "Invalid source dictionaries provided. Provide 'all', a single dictionary, or a comma-separated list of dictionaries excluding 'all'."
  end
end
