defmodule Words.RandomWords do
  @moduledoc """
  get random_words
  """
  alias Formatter.ParamTypes

  @typedoc """
  optional parameter that can be passed to 'get_random_words' query
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
  map or list of optional parameters that can be passed to 'get_random_words' query
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
  parsed JSON response to 'get_random_words' query
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

  defp format_url(api_key) do
    "http://api.wordnik.com/v4/words.json/randomWords?api_key=#{api_key}"
  end

  @doc """
  get random_words for requested word

  `get_random_words("SECRET_KEY", [:has_dictionary_def, sort_by: "alpha", sort_order: "asc"])`

  """
  @spec get_random_words(String.t(), random_words_params()) ::
          {:error, String.t()} | {:ok, random_words()}
  def get_random_words(api_key, params \\ []) do
    {fn_name, _} = __ENV__.function

    format_url(api_key)
    |> Formatter.Params.validate_and_fetch_query(params, @valid_params, fn_name)
  end
end
