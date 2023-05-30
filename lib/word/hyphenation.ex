defmodule Word.Hyphenation do
  @moduledoc """
  hyphenation information about requested word
  """
  alias Formatter.ParamTypes

  @typedoc """
  optional parameter that can be passed to `get_hyphenation/2` query
  """
  @type hyphenation_param ::
          ParamTypes.use_canonical() | ParamTypes.limit() | ParamTypes.source_dict()

  @typedoc """
  map or list of optional parameters that can be passed to `get_hyphenation/2` query
  """
  @type hyphenation_params ::
          %{
            optional(:use_canonical) => boolean(),
            optional(:limit) => integer(),
            optional(:source_dict) => String.t()
          }
          | list(hyphenation_param())

  @typedoc """
  parsed JSON response to `get_hyphenation/2` query
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

  defp format_url(word) do
    "http://api.wordnik.com/v4/word.json/#{word}/hyphenation"
  end

  @doc """
  get hyphenation for requested word

  ### Parameters
  - use_canonical: boolean
  - limit: integer
  - source_dict: string

  ### Example

  `iex> get_hyphenation("verbose", [:use_canonical])`

  ### Wordnik Docs

  https://developer.wordnik.com/docs#!/word/getHyphenation
  """
  @spec get_hyphenation(String.t(), hyphenation_params()) ::
          {:error, String.t()} | {:ok, hyphenation()}
  def get_hyphenation(word, params \\ []) do
    {fn_name, _} = __ENV__.function

    word
    |> format_url
    |> Formatter.Params.validate_and_fetch_query(params, @valid_params, fn_name)
  end
end
