defmodule Wordnik do
  @moduledoc """
  queries to the Wordnik API for word definitions, examples, related words, random words, and more
  """

  @doc """
  get audio information for requested word, including link to recording

  `get_audio("Havana", "SECRET_KEY", [:use_canonical, limit: 5])`

  """
  @spec get_audio(String.t(), String.t(), Word.Audio.audio_params()) ::
          {:error, String.t()} | {:ok, list(Word.Audio.audio())}
  def get_audio(word, api_key, params \\ []), do: Word.Audio.get_audio(word, api_key, params)

  @doc """
  get definition(s) for requested word

  `get_definitions("verbose", "SECRET_KEY", [part_of_speech: "noun", limit: 5])`

  """
  @spec get_definitions(String.t(), String.t(), Word.Definitions.definitions_params()) ::
          {:error, String.t()} | {:ok, list(Word.Definitions.definition())}
  def get_definitions(word, api_key, params \\ []),
    do: Word.Definitions.get_definitions(word, api_key, params)

  @doc """
  get etymologies for requested word

  `get_etymologies("verbose", "SECRET_KEY", [:use_canonical])`

  """
  @spec get_etymologies(String.t(), String.t(), Word.Etymologies.etymologies_params()) ::
          {:error, String.t()} | {:ok, Word.Etymologies.etymology()}
  def get_etymologies(word, api_key, params \\ []),
    do: Word.Etymologies.get_etymologies(word, api_key, params)

  @doc """
  get examples for requested word

  `get_examples("verbose", "SECRET_KEY", [:use_canonical, limit: 5])`

  """
  @spec get_examples(String.t(), String.t(), Word.Examples.examples_params()) ::
          {:error, String.t()} | {:ok, Word.Examples.example()}
  def get_examples(word, api_key, params \\ []),
    do: Word.Examples.get_examples(word, api_key, params)

  def get_frequency(word, api_key, params \\ []),
    do: Word.Frequency.get_frequency(word, api_key, params)

  def get_hyphenation(word, api_key, params \\ []),
    do: Word.Hyphenation.get_hyphenation(word, api_key, params)

  def get_phrases(word, api_key, params \\ []),
    do: Word.Phrases.get_phrases(word, api_key, params)

  def get_pronunciations(word, api_key, params \\ []),
    do: Word.Pronunciations.get_pronunciations(word, api_key, params)

  def get_related_words(word, api_key, params \\ []),
    do: Word.RelatedWords.get_related_words(word, api_key, params)

  def get_scrabble_score(word, api_key),
    do: Word.ScrabbleScore.get_scrabble_score(word, api_key)

  def get_top_example(word, api_key, params \\ []),
    do: Word.TopExample.get_top_example(word, api_key, params)

  def get_random_word(api_key, params \\ []),
    do: Words.RandomWord.get_random_word(api_key, params)

  def get_random_words(api_key, params \\ []),
    do: Words.RandomWords.get_random_words(api_key, params)

  def get_word_of_the_day(api_key, params),
    do: Words.WordOfTheDay.get_word_of_the_day(api_key, params)
end
