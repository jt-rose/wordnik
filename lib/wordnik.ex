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

  @doc """
  get frequency for requested word

  `get_frequency("verbose", "SECRET_KEY", [:use_canonical, start_year: 1990, end_year: 2000])`

  """
  @spec get_frequency(String.t(), String.t(), Word.Frequency.frequency_params()) ::
          {:error, String.t()} | {:ok, Word.Frequency.frequency()}
  def get_frequency(word, api_key, params \\ []),
    do: Word.Frequency.get_frequency(word, api_key, params)

  @doc """
  get hyphenation for requested word

  `get_hyphenation("verbose", "SECRET_KEY", [:use_canonical])`

  """
  @spec get_hyphenation(String.t(), String.t(), Word.Hyphenation.hyphenation_params()) ::
          {:error, String.t()} | {:ok, Word.Hyphenation.hyphenation()}
  def get_hyphenation(word, api_key, params \\ []),
    do: Word.Hyphenation.get_hyphenation(word, api_key, params)

  @doc """
  get phrases for requested word

  `get_phrases("verbose", "SECRET_KEY", [:use_canonical, limit: 5])`

  """
  @spec get_phrases(String.t(), String.t(), Word.Phrases.phrases_params()) ::
          {:error, String.t()} | {:ok, Word.Phrases.phrases()}
  def get_phrases(word, api_key, params \\ []),
    do: Word.Phrases.get_phrases(word, api_key, params)

  @doc """
  get pronunciations for requested word

  `get_pronunciations("verbose", "SECRET_KEY", [:use_canonical, limit: 5])`

  """
  @spec get_pronunciations(String.t(), String.t(), Word.Pronunciations.pronunciations_params()) ::
          {:error, String.t()} | {:ok, Word.Pronunciations.pronunciations()}
  def get_pronunciations(word, api_key, params \\ []),
    do: Word.Pronunciations.get_pronunciations(word, api_key, params)

  @doc """
  get related_words for requested word

  `get_related_words("verbose", "SECRET_KEY", [:use_canonical, relationship_types: "synonym"])`

  """
  @spec get_related_words(String.t(), String.t(), Word.RelatedWords.related_words_params()) ::
          {:error, String.t()} | {:ok, Word.RelatedWords.related_words()}
  def get_related_words(word, api_key, params \\ []),
    do: Word.RelatedWords.get_related_words(word, api_key, params)

  @doc """
  get scrabble_score for requested word

  `get_scrabble_score("verbose", "SECRET_KEY")`

  """
  @spec get_scrabble_score(String.t(), String.t()) ::
          {:error, String.t()} | {:ok, Word.ScrabbleScore.scrabble_score()}
  def get_scrabble_score(word, api_key),
    do: Word.ScrabbleScore.get_scrabble_score(word, api_key)

  @doc """
  get top_example for requested word

  `get_top_example("verbose", "SECRET_KEY", [:use_canonical])`

  """
  @spec get_top_example(String.t(), String.t(), Word.TopExample.top_example_params()) ::
          {:error, String.t()} | {:ok, Word.Examples.example()}
  def get_top_example(word, api_key, params \\ []),
    do: Word.TopExample.get_top_example(word, api_key, params)

  @doc """
  get random_word for requested word

  `get_random_word("SECRET_KEY", [:has_dictionary_def, min_length: 5])`

  """
  @spec get_random_word(String.t(), Words.RandomWord.random_word_params()) ::
          {:error, String.t()} | {:ok, Words.RandomWord.random_word()}
  def get_random_word(api_key, params \\ []),
    do: Words.RandomWord.get_random_word(api_key, params)

  @doc """
  get random_words for requested word

  `get_random_words("SECRET_KEY", [:has_dictionary_def, sort_by: "alpha", sort_order: "asc"])`

  """
  @spec get_random_words(String.t(), Words.RandomWords.random_words_params()) ::
          {:error, String.t()} | {:ok, Words.RandomWords.random_words()}
  def get_random_words(api_key, params \\ []),
    do: Words.RandomWords.get_random_words(api_key, params)

  @doc """
  get word_of_the_day for requested word

  `get_word_of_the_day("SECRET_KEY", [date: "1985-12-31])`

  """
  @spec get_word_of_the_day(String.t(), Words.WordOfTheDay.word_of_the_day_params()) ::
          {:error, String.t()} | {:ok, Words.WordOfTheDay.word_of_the_day()}
  def get_word_of_the_day(api_key, params),
    do: Words.WordOfTheDay.get_word_of_the_day(api_key, params)
end
