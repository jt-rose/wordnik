defmodule Words.RandomWords do
  @moduledoc """
  get random_words
  """
  alias Formatter.ParamTypes

  @typedoc """
  optional parameter that can be passed to `get_random_words/1` query
  """
  @type random_words_param ::
          ParamTypes.has_dictionary_def()
          | ParamTypes.include_part_of_speech()
          | ParamTypes.exclude_part_of_speech()
          | ParamTypes.min_corpus_count()
          | ParamTypes.max_corpus_count()
          | ParamTypes.min_dictionary_count()
          | ParamTypes.max_dictionary_count()
          | ParamTypes.min_length()
          | ParamTypes.max_length()
          | ParamTypes.sort_by()
          | ParamTypes.sort_order()

  @typedoc """
  map or list of optional parameters that can be passed to `get_random_words/1` query
  """
  @type random_words_params ::
          %{
            optional(:has_dictionary_def) => boolean(),
            optional(:include_part_of_speech) => String.t(),
            optional(:exclude_part_of_speech) => String.t(),
            optional(:min_corpus_count) => integer(),
            optional(:max_corpus_count) => integer(),
            optional(:min_dictionary_count) => integer(),
            optional(:max_dictionary_count) => integer(),
            optional(:min_length) => integer(),
            optional(:max_length) => integer(),
            optional(:sort_by) => String.t(),
            optional(:sort_order) => String.t()
          }
          | list(random_words_param())

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
  iex> get_random_words([:has_dictionary_def, sort_by: "alpha", sort_order: "asc"])
  ```

  ### Wordnik Docs

  https://developer.wordnik.com/docs#!/word/getRandomWords
  """
  @spec get_random_words(random_words_params()) ::
          {:error, String.t()} | {:ok, random_words()}
  def get_random_words(params \\ []) do
    {fn_name, _} = __ENV__.function

    Formatter.Params.validate_and_fetch_query(
      "http://api.wordnik.com/v4/words.json/randomWords",
      params,
      @valid_params,
      fn_name
    )
  end
end
