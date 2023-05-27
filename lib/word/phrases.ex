defmodule Word.Phrases do
  @moduledoc """
  phrases that include the selected word
  """
  alias Formatter.ParamTypes

  @typedoc """
  optional parameter that can be passed to 'get_phrases' query
  """
  @type phrases_param :: ParamTypes.use_canonical() | ParamTypes.limit() | ParamTypes.wlmi()

  @typedoc """
  map or list of optional parameters that can be passed to 'get_phrases' query
  """
  @type phrases_params ::
          %{
            optional(:use_canonical) => boolean(),
            optional(:limit) => integer(),
            optional(:wlmi) => integer()
          }
          | list(phrases_param())

  @typedoc """
  parsed JSON response to 'get_phrases' query
  """
  @type phrases ::
          list(%{
            count: integer,
            gram1: String.t(),
            gram2: String.t(),
            mi: integer,
            wlmi: integer
          })

  @valid_params [
    :limit,
    :wlmi,
    :use_canonical
  ]

  defp format_url(word, api_key) do
    "http://api.wordnik.com/v4/word.json/#{word}/phrases?api_key=#{api_key}"
  end

  @doc """
  get phrases for requested word

  `get_phrases("verbose", "SECRET_KEY", [:use_canonical, limit: 5])`

  """
  @spec get_phrases(String.t(), String.t(), phrases_params()) ::
          {:error, String.t()} | {:ok, phrases()}
  def get_phrases(word, api_key, params \\ []) do
    {fn_name, _} = __ENV__.function

    format_url(word, api_key)
    |> Formatter.Params.validate_and_fetch_query(params, @valid_params, fn_name)
  end
end
