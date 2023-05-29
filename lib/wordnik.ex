defmodule Wordnik do
  @moduledoc """
  queries to the Wordnik API for word definitions, examples, related words, random words, and more
  """

  @doc """
  get audio information for requested word, including link to recording

  `iex> get_audio("Havana", [:use_canonical, limit: 5])`

  """
  @spec get_audio(String.t(), Word.Audio.audio_params()) ::
          {:error, String.t()} | {:ok, list(Word.Audio.audio())}
  def get_audio(word, params \\ []), do: Word.Audio.get_audio(word, params)

  @doc """
  get definition(s) for requested word

  `iex> get_definitions("verbose",[part_of_speech: "noun", limit: 5])`

  """
  @spec get_definitions(String.t(), Word.Definitions.definitions_params()) ::
          {:error, String.t()} | {:ok, list(Word.Definitions.definition())}
  def get_definitions(word, params \\ []),
    do: Word.Definitions.get_definitions(word, params)

  @doc """
  get etymologies for requested word

  `iex> get_etymologies("verbose", [:use_canonical])`

  """
  @spec get_etymologies(String.t(), Word.Etymologies.etymologies_params()) ::
          {:error, String.t()} | {:ok, Word.Etymologies.etymology()}
  def get_etymologies(word, params \\ []),
    do: Word.Etymologies.get_etymologies(word, params)

  @doc """
  get examples for requested word

  `iex> get_examples("verbose", [:use_canonical, limit: 5])`

  """
  @spec get_examples(String.t(), Word.Examples.examples_params()) ::
          {:error, String.t()} | {:ok, Word.Examples.example()}
  def get_examples(word, params \\ []),
    do: Word.Examples.get_examples(word, params)

  @doc """
  get frequency for requested word

  `iex> get_frequency("verbose", [:use_canonical, start_year: 1990, end_year: 2000])`

  """
  @spec get_frequency(String.t(), Word.Frequency.frequency_params()) ::
          {:error, String.t()} | {:ok, Word.Frequency.frequency()}
  def get_frequency(word, params \\ []),
    do: Word.Frequency.get_frequency(word, params)

  @doc """
  get hyphenation for requested word

  `iex> get_hyphenation("verbose", [:use_canonical])`

  """
  @spec get_hyphenation(String.t(), Word.Hyphenation.hyphenation_params()) ::
          {:error, String.t()} | {:ok, Word.Hyphenation.hyphenation()}
  def get_hyphenation(word, params \\ []),
    do: Word.Hyphenation.get_hyphenation(word, params)

  @doc """
  get phrases for requested word

  `iex> get_phrases("verbose", [:use_canonical, limit: 5])`

  """
  @spec get_phrases(String.t(), Word.Phrases.phrases_params()) ::
          {:error, String.t()} | {:ok, Word.Phrases.phrases()}
  def get_phrases(word, params \\ []),
    do: Word.Phrases.get_phrases(word, params)

  @doc """
  get pronunciations for requested word

  `iex> get_pronunciations("verbose", [:use_canonical, limit: 5])`

  """
  @spec get_pronunciations(String.t(), Word.Pronunciations.pronunciations_params()) ::
          {:error, String.t()} | {:ok, Word.Pronunciations.pronunciations()}
  def get_pronunciations(word, params \\ []),
    do: Word.Pronunciations.get_pronunciations(word, params)

  @doc """
  get related_words for requested word

  `iex> get_related_words("verbose", [:use_canonical, relationship_types: "synonym"])`

  """
  @spec get_related_words(String.t(), Word.RelatedWords.related_words_params()) ::
          {:error, String.t()} | {:ok, Word.RelatedWords.related_words()}
  def get_related_words(word, params \\ []),
    do: Word.RelatedWords.get_related_words(word, params)

  @doc """
  get scrabble_score for requested word

  `iex> get_scrabble_score("verbose", "SECRET_API_KEY")`

  """
  @spec get_scrabble_score(String.t()) ::
          {:error, String.t()} | {:ok, Word.ScrabbleScore.scrabble_score()}
  def get_scrabble_score(word),
    do: Word.ScrabbleScore.get_scrabble_score(word)

  @doc """
  get top_example for requested word

  `iex> get_top_example("verbose", [:use_canonical])`

  """
  @spec get_top_example(String.t(), Word.TopExample.top_example_params()) ::
          {:error, String.t()} | {:ok, Word.Examples.example()}
  def get_top_example(word, params \\ []),
    do: Word.TopExample.get_top_example(word, params)

  @doc """
  get random_word for requested word

  `iex> get_random_word([:has_dictionary_def, min_length: 5])`

  """
  @spec get_random_word(Words.RandomWord.random_word_params()) ::
          {:error, String.t()} | {:ok, Words.RandomWord.random_word()}
  def get_random_word(params \\ []),
    do: Words.RandomWord.get_random_word(params)

  @doc """
  get random_words for requested word

  `iex> get_random_words([:has_dictionary_def, sort_by: "alpha", sort_order: "asc"])`

  """
  @spec get_random_words(Words.RandomWords.random_words_params()) ::
          {:error, String.t()} | {:ok, Words.RandomWords.random_words()}
  def get_random_words(params \\ []),
    do: Words.RandomWords.get_random_words(params)

  @doc """
  get word_of_the_day for requested word

  `iex> get_word_of_the_day([date: "1985-12-31])`

  """
  @spec get_word_of_the_day(Words.WordOfTheDay.word_of_the_day_params()) ::
          {:error, String.t()} | {:ok, Words.WordOfTheDay.word_of_the_day()}
  def get_word_of_the_day(params),
    do: Words.WordOfTheDay.get_word_of_the_day(params)
end
