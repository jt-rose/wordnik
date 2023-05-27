defmodule Word.TopExample do
  @moduledoc """
  find top-rated example for requested word
  """
  alias Formatter.ParamTypes

  @typedoc """
  optional parameter that can be passed to 'get_top_example' query
  """
  @type top_example_param :: ParamTypes.use_canonical()

  @typedoc """
  map or list of optional parameters that can be passed to 'get_top_example' query
  """
  @type top_example_params ::
          %{
            optional(:use_canonical) => boolean()
          }
          | list(top_example_param())

  @valid_params [
    :use_canonical
  ]

  defp format_url(word, api_key) do
    "http://api.wordnik.com/v4/word.json/#{word}/topExample?api_key=#{api_key}"
  end

  @doc """
  get top_example for requested word

  `get_top_example("verbose", "SECRET_KEY", [:use_canonical])`

  """
  @spec get_top_example(String.t(), String.t(), top_example_params()) ::
          {:error, String.t()} | {:ok, Word.Examples.example()}
  def get_top_example(word, api_key, params \\ []) do
    {fn_name, _} = __ENV__.function

    format_url(word, api_key)
    |> Formatter.Params.validate_and_fetch_query(params, @valid_params, fn_name)
  end
end
