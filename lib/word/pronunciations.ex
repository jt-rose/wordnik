defmodule Word.Pronunciations do
  @moduledoc """
  pronunciation information for requested word
  """
  alias Formatter.ParamTypes

  @typedoc """
  optional parameter that can be passed to 'get_pronunciations' query
  """
  @type pronunciations_param ::
          ParamTypes.use_canonical()
          | ParamTypes.limit()
          | ParamTypes.source_dict()
          | ParamTypes.type_format()

  @typedoc """
  map or list of optional parameters that can be passed to 'get_pronunciations' query
  """
  @type pronunciations_params ::
          %{
            optional(:use_canonical) => boolean(),
            optional(:limit) => integer(),
            optional(:source_dict) => String.t(),
            optional(:type_format) => String.t()
          }
          | list(pronunciations_param())

  @typedoc """
  parsed JSON response to 'get_pronunciations' query
  """
  @type pronunciations ::
          list(%{
            optional(:id) => String.t(),
            optional(:attributionText) => String.t(),
            optional(:attributionUrl) => String.t(),
            seq: integer,
            raw: String.t(),
            rawType: String.t()
          })

  @valid_params [
    :limit,
    :type_format,
    :source_dict,
    :use_canonical
  ]

  defp format_url(word, api_key) do
    "http://api.wordnik.com/v4/word.json/#{word}/definitions?api_key=#{api_key}"
  end

  @doc """
  get pronunciations for requested word

  `get_pronunciations("verbose", "SECRET_KEY", [:use_canonical, limit: 5])`

  """
  @spec get_pronunciations(String.t(), String.t(), pronunciations_params()) ::
          {:error, String.t()} | {:ok, pronunciations()}
  def get_pronunciations(word, api_key, params \\ []) do
    {fn_name, _} = __ENV__.function

    format_url(word, api_key)
    |> Formatter.Params.validate_and_fetch_query(params, @valid_params, fn_name)
  end
end
