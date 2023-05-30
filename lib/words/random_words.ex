defmodule Words.RandomWords do
  @moduledoc """
  get random_words
  """
  alias Formatter.Query

  @typedoc """
  map or list of optional parameters that can be passed to `get_random_words/1` query
  """
  @type random_words_params ::
          %{
            optional(:has_dictionary_def) => boolean(),
            optional(:include_part_of_speech) => Formatter.Enums.include_part_of_speech(),
            optional(:exclude_part_of_speech) => Formatter.Enums.exclude_part_of_speech(),
            optional(:min_corpus_count) => integer(),
            optional(:max_corpus_count) => integer(),
            optional(:min_dictionary_count) => integer(),
            optional(:max_dictionary_count) => integer(),
            optional(:min_length) => integer(),
            optional(:max_length) => integer(),
            optional(:sort_by) => Formatter.Enums.sort_by(),
            optional(:sort_order) => Formatter.Enums.sort_order()
          }

  @typedoc """
  parsed JSON response to `get_random_words/1` query
  """
  @type random_words ::
          list(Words.RandomWord.random_word())

  @valid_params [
    :has_dictionary_def,
    :include_part_of_speech,
    :exclude_part_of_speech,
    :min_corpus_count,
    :max_corpus_count,
    :min_dictionary_count,
    :max_dictionary_count,
    :min_length,
    :max_length,
    :limit,
    :sort_by,
    :sort_order
  ]

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
  @spec get_random_words(random_words_params()) ::
          {:error, String.t()} | {:ok, random_words()}
  def get_random_words(params \\ %{}) do
    {fn_name, _} = __ENV__.function

    Query.validate_and_fetch_query(
      "http://api.wordnik.com/v4/words.json/randomWords",
      params,
      @valid_params,
      fn_name
    )
  end
end
