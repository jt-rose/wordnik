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

## Usage

The main functions for querying the Wordnik API can be found under the root `Wordnik` module. Most of what you will need can be found here.

Submodules such as `Word.Definitions` and `Words.RandomWord` contain the function they are named for, along with type definitions for query parameters and responses.

`Formatter.Enums` contains type definitions for string parameter arguments expecting specific values. These values will be checked at runtime, but are also documented in the typedocs.

`Formatter.Helpers` contains functions for returning lists of valid string arguments used in the paramaters mentioned above (dictionaries, parts of speech, etc.). These can be helpful for quickly getting a list of valid options to provide to end users, for example as select options in a UI.

## Wordnik API key

To access the Wordnik API, you will need a free API key that can be obtained [here](https://developer.wordnik.com/).

This key will need to be set as an environmental variable called `WORDNIK_API_KEY` and the wordnik library will pick it up automatically. If this key is not present the library will alert you with an error tuple:

```elixir
{:error, "'WORDNIK_API_KEY' could not be loaded from environment"}
```

## Sample Query

```elixir
iex> Wordnik.get_definitions("sublime")
{:ok, definitions_response}
```

## Passing Parameters

Optional parameters can be passed as a map to queries to help refine them:

```elixir
iex> Wordnik.get_definitions("sublime", %{
  "include_tags" => true,
  "include_related" => true,
  "source_dictionaries" => "wiktionary,webster",
  "limit" =>  5
})
```

If no parameters are needed, you can skip the params argument:

```elixir
iex> Wordnik.get_definitions("sublime")
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
