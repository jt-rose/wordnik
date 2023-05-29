defmodule Word.Etymologies do
  @moduledoc """
  etymologies for a given word
  """

  alias Formatter.ParamTypes

  @typedoc """
  optional parameter that can be passed to 'get_etymologies' query
  """
  @type etymologies_param ::
          ParamTypes.use_canonical()

  @typedoc """
  map or list of optional parameters that can be passed to 'get_etymologies' query
  """
  @type etymologies_params ::
          %{
            optional(:use_canonical) => boolean
          }
          | list(etymologies_param())

  @typedoc """
          parsed JSON response to 'get_etymologies' query
  """
  @type etymology :: String.t()

  @valid_params [
    :use_canonical
  ]

  defp format_url(word, api_key) do
    "http://api.wordnik.com/v4/word.json/#{word}/etymologies?api_key=#{api_key}"
  end

  @doc """
  get etymologies for requested word

  `iex> get_etymologies("verbose", "SECRET_API_KEY", [:use_canonical])`

  """
  @spec get_etymologies(String.t(), String.t(), etymologies_params()) ::
          {:error, String.t()} | {:ok, etymology()}
  def get_etymologies(word, api_key, params \\ []) do
    {fn_name, _} = __ENV__.function

    format_url(word, api_key)
    |> Formatter.Params.validate_and_fetch_query(params, @valid_params, fn_name)
  end
end
