defmodule Words.RandomWord do
  @moduledoc """
  get random word
  """
  alias Formatter.ParamTypes
  alias Formatter.Query

  @typedoc """
  optional parameter that can be passed to `get_random_word/1` query
  """
  @type random_word_param ::
          ParamTypes.has_dictionary_def()
          | ParamTypes.include_part_of_speech()
          | ParamTypes.exclude_part_of_speech()
          | ParamTypes.min_corpus_count()
          | ParamTypes.max_corpus_count()
          | ParamTypes.min_dictionary_count()
          | ParamTypes.max_dictionary_count()
          | ParamTypes.min_length()
          | ParamTypes.max_length()

  @typedoc """
  map or list of optional parameters that can be passed to `get_random_word/1` query
  """
  @type random_word_params ::
          %{
            optional(:has_dictionary_def) => boolean(),
            optional(:include_part_of_speech) => String.t(),
            optional(:exclude_part_of_speech) => String.t(),
            optional(:min_corpus_count) => integer(),
            optional(:max_corpus_count) => integer(),
            optional(:min_dictionary_count) => integer(),
            optional(:max_dictionary_count) => integer(),
            optional(:min_length) => integer(),
            optional(:max_length) => integer()
          }
          | list(random_word_param())

  @typedoc """
  parsed JSON response to `get_random_word/1` query
  """
  @type random_word ::
          %{
            id: integer,
            word: String.t()
          }

  @valid_params [
    :has_dictionary_def,
    :include_part_of_speech,
    :exclude_part_of_speech,
    :min_corpus_count,
    :max_corpus_count,
    :min_dictionary_count,
    :max_dictionary_count,
    :min_length,
    :max_length
  ]

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
  iex> get_random_word( [:has_dictionary_def, min_length: 5])
  ```
  ### Response
  `t:Words.RandomWord.random_word/0`

  ### Wordnik Docs
  https://developer.wordnik.com/docs#!/word/getRandomWord
  """
  @spec get_random_word(random_word_params()) ::
          {:error, String.t()} | {:ok, random_word()}
  def get_random_word(params \\ []) do
    {fn_name, _} = __ENV__.function

    Query.validate_and_fetch_query(
      "http://api.wordnik.com/v4/words.json/randomWord",
      params,
      @valid_params,
      fn_name
    )
  end
end
