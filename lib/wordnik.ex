defmodule Wordnik do
  @moduledoc """
  queries to the Wordnik API for word definitions, examples, related words, random words, and more
  """

  alias Wordnik.Word
  alias Wordnik.Words

  @doc """
  get audio information for requested word, including link to recording

  ### Parameters
  - limit: integer
  - use_canonical: boolean

  ### Example
  ```elixir
  iex> get_audio("Havana", %{use_canonical: true: true, limit: 5})
  ```

  ### Response
  `t:Word.Audio.audio/0`

  ### Wordnik Docs
  https://developer.wordnik.com/docs#!/word/getAudio
  """
  @spec get_audio(String.t(), Word.Audio.audio_params()) ::
          {:error, String.t()} | {:ok, Word.Audio.audio()}
  def get_audio(word, params \\ %{}), do: Word.Audio.get_audio(word, params)

  @doc """
  get definition(s) for requested word

  ### Parameters
  - use_canonical: boolean
  - include_related: boolean
  - include_tags: boolean
  - limit: integer
  - part_of_speech: string
  - source_dictionaries: string

  ### Example
  ```elixir
  iex> get_definitions("verbose", %{part_of_speech: "noun", limit: 5})
  ```

  ### Response
  `t:Word.Definitions.definitions/0`

  ### Wordnik Docs
  https://developer.wordnik.com/docs#!/word/getDefinitions
  """
  @spec get_definitions(String.t(), Word.Definitions.definitions_params()) ::
          {:error, String.t()} | {:ok, Word.Definitions.definitions()}
  def get_definitions(word, params \\ %{}),
    do: Word.Definitions.get_definitions(word, params)

  @doc """
  get etymologies for requested word

  ### Parameters
  - use_canonical: boolean

  ### Example
  ```elixir
  iex> get_etymologies("verbose", %{use_canonical: true})
  ```

  ### Response
  `t:Word.Etymologies.etymology/0`

  ### Wordnik Docs
  https://developer.wordnik.com/docs#!/word/getEtymologies
  """
  @spec get_etymologies(String.t(), Word.Etymologies.etymologies_params()) ::
          {:error, String.t()} | {:ok, Word.Etymologies.etymology()}
  def get_etymologies(word, params \\ %{}),
    do: Word.Etymologies.get_etymologies(word, params)

  @doc """
  get examples for requested word

  ### Parameters
  - use_canonical: boolean
  - include_duplicates: boolean
  - limit: integer
  - skip: integer

  ### Example
  ```elixir
  iex> get_examples("verbose", %{use_canonical: true, limit: 5})
  ```

  ### Response
  `t:Word.Examples.examples/0`

  ### Wordnik Docs
  https://developer.wordnik.com/docs#!/word/getExamples
  """
  @spec get_examples(String.t(), Word.Examples.examples_params()) ::
          {:error, String.t()} | {:ok, Word.Examples.examples()}
  def get_examples(word, params \\ %{}),
    do: Word.Examples.get_examples(word, params)

  @doc """
  get frequency for requested word

  ### Parameters
  - use_canonical: boolean
  - start_year: integer
  - end_year: integer

  ### Example
  ```elixir
  iex> get_frequency("verbose", %{use_canonical: true, start_year: 1990, end_year: 2000})
  ```

  ### Response
  `t:Word.Frequency.frequency/0`

  ### Wordnik Docs
  https://developer.wordnik.com/docs#!/word/getWordFrequency
  """
  @spec get_frequency(String.t(), Word.Frequency.frequency_params()) ::
          {:error, String.t()} | {:ok, Word.Frequency.frequency()}
  def get_frequency(word, params \\ %{}),
    do: Word.Frequency.get_frequency(word, params)

  @doc """
  get hyphenation for requested word

  ### Parameters
  - use_canonical: boolean
  - limit: integer
  - source_dict: string

  ### Example
  ```elixir
  iex> get_hyphenation("verbose", %{use_canonical: true})
  ```

  ### Response
  `t:Word.Hyphenation.hyphenation/0`

  ### Wordnik Docs
  https://developer.wordnik.com/docs#!/word/getHyphenation
  """
  @spec get_hyphenation(String.t(), Word.Hyphenation.hyphenation_params()) ::
          {:error, String.t()} | {:ok, Word.Hyphenation.hyphenation()}
  def get_hyphenation(word, params \\ %{}),
    do: Word.Hyphenation.get_hyphenation(word, params)

  @doc """
  get phrases for requested word

  ### Parameters
  - use_canonical: boolean
  - limit: integer
  - wlmi: string

  ### Example
  ```elixir
  iex> get_phrases("verbose", %{use_canonical: true, limit: 5})
  ```

  ### Response
  `t:Word.Phrases.phrases/0`

  ### Wordnik Docs
  https://developer.wordnik.com/docs#!/word/getPhrases
  """
  @spec get_phrases(String.t(), Word.Phrases.phrases_params()) ::
          {:error, String.t()} | {:ok, Word.Phrases.phrases()}
  def get_phrases(word, params \\ %{}),
    do: Word.Phrases.get_phrases(word, params)

  @doc """
  get pronunciations for requested word

  ### Parameters
  - use_canonical: boolean
  - limit: integer
  - type_format: string
  - source_dict: string

  ### Example
  ```elixir
  iex> get_pronunciations("verbose", %{use_canonical: true, limit: 5})
  ```

  ### Response
  `t:Word.Pronunciations.pronunciations/0`

  ### Wordnik Docs
  https://developer.wordnik.com/docs#!/word/getTextPronunciations
  """
  @spec get_pronunciations(String.t(), Word.Pronunciations.pronunciations_params()) ::
          {:error, String.t()} | {:ok, Word.Pronunciations.pronunciations()}
  def get_pronunciations(word, params \\ %{}),
    do: Word.Pronunciations.get_pronunciations(word, params)

  @doc """
  get related_words for requested word

  ### Parameters
  - use_canonical: boolean
  - limit: integer
  - relationship_types: string

  ### Example
  ```elixir
  iex> get_related_words("verbose", %{use_canonical: true, relationship_types: "synonym"})
  ```elixir

  ### Response
  `t:Word.RelatedWords.related_words/0`

  ### Wordnik Docs
  https://developer.wordnik.com/docs#!/word/getRelatedWords
  """
  @spec get_related_words(String.t(), Word.RelatedWords.related_words_params()) ::
          {:error, String.t()} | {:ok, Word.RelatedWords.related_words()}
  def get_related_words(word, params \\ %{}),
    do: Word.RelatedWords.get_related_words(word, params)

  @doc """
  get scrabble_score for requested word

  ### Example
  ```elixir
  iex> get_scrabble_score("verbose")
  ```

  ### Response
  `t:Word.ScrabbleScore.scrabble_score/0`

  ### Wordnik Docs
  https://developer.wordnik.com/docs#!/word/getScrabbleScore
  """
  @spec get_scrabble_score(String.t()) ::
          {:error, String.t()} | {:ok, Word.ScrabbleScore.scrabble_score()}
  def get_scrabble_score(word),
    do: Word.ScrabbleScore.get_scrabble_score(word)

  @doc """
  get top_example for requested word

  ### Parameters
  - use_canonical: boolean

  ### Example
  ```elixir
  iex> get_top_example("verbose", %{use_canonical: true})
  ```

  ### Response
  `t:Word.Examples.example/0`

  ### Wordnik Docs
  https://developer.wordnik.com/docs#!/word/getTopExample
  """
  @spec get_top_example(String.t(), Word.TopExample.top_example_params()) ::
          {:error, String.t()} | {:ok, Word.Examples.example()}
  def get_top_example(word, params \\ %{}),
    do: Word.TopExample.get_top_example(word, params)

  @doc """
  get random_word for requested word

  ### Parameters
  - has_dictionary_def: boolean
  - include_part_of_speech: string
  - exclude_part_of_speech: string
  - min_corpus_count: integer
  - max_corpus_count: integer
  - min_dictionary_count: integer
  - max_dictionary_count: integer
  - min_length: integer
  - max_length: integer

  ### Example
  ```elixir
  iex> get_random_word( %{has_dictionary_def: true, min_length: 5})
  ```

  ### Response
  `t:Words.RandomWord.random_word/0`

  ### Wordnik Docs
  https://developer.wordnik.com/docs#!/word/getRandomWord
  """
  @spec get_random_word(Words.RandomWord.random_word_params()) ::
          {:error, String.t()} | {:ok, Words.RandomWord.random_word()}
  def get_random_word(params \\ %{}),
    do: Words.RandomWord.get_random_word(params)

  @doc """
  get random_words for requested word

  ### Parameters
  - has_dictionary_def: boolean
  - include_part_of_speech: string
  - exclude_part_of_speech: string
  - min_corpus_count: integer
  - max_corpus_count: integer
  - min_dictionary_count: integer
  - max_dictionary_count: integer
  - min_length: integer
  - max_length: integer
  - limit: integer
  - sort_by: string
  - sort_order: string

  ### Example
  ```elixir
  iex> get_random_words(%{has_dictionary_def: true, sort_by: "alpha", sort_order: "asc"})
  ```

  ### Response
  `t:Words.RandomWords.random_words/0`

  ### Wordnik Docs
  https://developer.wordnik.com/docs#!/word/getRandomWords
  """
  @spec get_random_words(Words.RandomWords.random_words_params()) ::
          {:error, String.t()} | {:ok, Words.RandomWords.random_words()}
  def get_random_words(params \\ %{}),
    do: Words.RandomWords.get_random_words(params)

  @doc """
  get word_of_the_day for requested word

  ### Parameters
  - date: string

  ### Example
  ```elixir
  iex> get_word_of_the_day(%{date: "1985-12-31"})
  ```

  ### Response
  `t:Words.WordOfTheDay.word_of_the_day/0`

  ### Wordnik Docs
  https://developer.wordnik.com/docs#!/word/getWordOfTheDay
  """
  @spec get_word_of_the_day(Words.WordOfTheDay.word_of_the_day_params()) ::
          {:error, String.t()} | {:ok, Words.WordOfTheDay.word_of_the_day()}
  def get_word_of_the_day(params \\ %{}),
    do: Words.WordOfTheDay.get_word_of_the_day(params)
end
