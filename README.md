# Wordnik

A library for accessing the [Wordnik](https://developer.wordnik.com/) API

## Installation

The package can be installed by adding `wordnik` to your list of dependencies in `mix.exs` and running `mix.deps.get`:

```elixir
def deps do
  [
    {:wordnik, "~> 0.1.0"}
  ]
end
```

## Sample Query

```elixir
iex> Wordnik.get_definitions("sublime", "MY_SECRET_API_KEY")
{:ok, definitions_response}
```

## Passing Parameters

Optional parameters can be passed as a map to queries to help refine them:

```elixir
iex> Wordnik.get_definitions("sublime", "MY_SECRET_API_KEY", %{
  "include_tags" => true,
  "include_related" => true,
  "source_dictionaries" => "wiktionary,webster",
  "limit" =>  5
})
```

Parameters can also be expressed as a list:

```elixir
iex> Wordnik.get_definitions("sublime", "MY_SECRET_API_KEY", [
  include_tags: true,
  include_related: true,
  source_dictionaries: "wiktionary,webster",
  limit: 5
])
```

And when one of the fields has a boolean value of `true`, it can be further shortened by just providing the atom, but needs to come at the beginning of the list:

```elixir
iex> Wordnik.get_definitions("sublime", "MY_SECRET_API_KEY", [
  :include_tags,
  :include_related,
  source_dictionaries: "wiktionary,webster",
  limit: 5
])
```

The parameter fields for each query are based on the Wordnik documentation (linked to below) but follow elixir naming conventions (snake_case). The parameters are also listed in each function's typespecs and documentation. Lastly, parameters pass validation checks and return an error tuple `{:error, error_msg}` when an invalid parameter is provided.

## API Queries

The Wordnik package supports the following queries:

### Word

- [Audio](https://developer.wordnik.com/docs#!/word/getAudio)
- [Definitions](https://developer.wordnik.com/docs#!/word/getDefinitions)
- [Etymologies](https://developer.wordnik.com/docs#!/word/getEtymologies)
- [Examples](https://developer.wordnik.com/docs#!/word/getExamples)
- [Frequency](https://developer.wordnik.com/docs#!/word/getWordFrequency)
- [Hyphenation](https://developer.wordnik.com/docs#!/word/getHyphenation)
- [Phrases](https://developer.wordnik.com/docs#!/word/getPhrases)
- [Pronunciations](https://developer.wordnik.com/docs#!/word/getTextPronunciations)
- [Related Words](https://developer.wordnik.com/docs#!/word/getRelatedWords)
- [Scrabble Score](https://developer.wordnik.com/docs#!/word/getScrabbleScore)
- [Top Example](https://developer.wordnik.com/docs#!/word/getTopExample)

### Words

- [Random Word](https://developer.wordnik.com/docs#!/words/getRandomWord)
- [Random Words](https://developer.wordnik.com/docs#!/words/getRandomWords)
- [Word of the Day](https://developer.wordnik.com/docs#!/words/getWordOfTheDay)

Note: The [Reverse Dictionary](https://developer.wordnik.com/docs#!/words/reverseDictionary) and [Search](https://developer.wordnik.com/docs#!/words/searchWords) queries are currently deprecated until the upcoming v5 release of Wordnik. Once the new queries are made available they will be included in the library.

## Links

- [Wordnik](https://developer.wordnik.com/)
- [HexDocs](https://hexdocs.pm/wordnik)
- [Github Repo](https://github.com/jt-rose/wordnik)
