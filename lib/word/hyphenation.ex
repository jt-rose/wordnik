defmodule Word.Hyphenation do
  @moduledoc """
  hyphenation information about requested word
  """
  alias Formatter.ParamTypes

  @typedoc """
  optional parameter that can be passed to 'get_hyphenation' query
  """
  @type hyphenation_param ::
          ParamTypes.use_canonical() | ParamTypes.limit() | ParamTypes.source_dict()

  @typedoc """
  map or list of optional parameters that can be passed to 'get_hyphenation' query
  """
  @type hyphenation_params ::
          %{
            optional(:use_canonical) => boolean(),
            optional(:limit) => integer(),
            optional(:source_dict) => String.t()
          }
          | list(hyphenation_param())

  @typedoc """
  parsed JSON response to 'get_hyphenation' query
  """
  @type hyphenation ::
          list(%{
            optional(:type) => String.t(),
            text: String.t(),
            seq: integer
          })

  @valid_params [
    :limit,
    :source_dict,
    :use_canonical
  ]

  defp format_url(word, api_key) do
    "http://api.wordnik.com/v4/word.json/#{word}/hyphenation?api_key=#{api_key}"
  end

  @doc """
  get hyphenation for requested word

  `get_hyphenation("verbose", "SECRET_KEY", [:use_canonical])`

  """
  @spec get_hyphenation(String.t(), String.t(), hyphenation_params()) ::
          {:error, String.t()} | {:ok, hyphenation()}
  def get_hyphenation(word, api_key, params \\ []) do
    {fn_name, _} = __ENV__.function

    format_url(word, api_key)
    |> Formatter.Params.validate_and_fetch_query(params, @valid_params, fn_name)
  end
end
