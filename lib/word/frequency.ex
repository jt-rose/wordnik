defmodule Word.Frequency do
  @moduledoc """
  frequency of usage across years for the requested word
  """
  alias Formatter.ParamTypes

  @typedoc """
  optional parameter that can be passed to 'get_frequency' query
  """
  @type frequency_param ::
          ParamTypes.use_canonical() | ParamTypes.start_year() | ParamTypes.end_year()

  @typedoc """
  map or list of optional parameters that can be passed to 'get_frequency' query
  """
  @type frequency_params ::
          %{
            optional(:start_year) => integer(),
            optional(:end_year) => integer(),
            optional(:use_canonical) => boolean()
          }
          | list(frequency_param())

  @typedoc """
  parsed JSON response to 'get_frequency' query
  """
  @type frequency ::
          %{
            frequency: list(%{year: String.t(), count: integer}),
            frequencyString: String.t(),
            totalCount: integer,
            unknownYearCount: integer,
            word: String.t()
          }

  @valid_params [
    :start_year,
    :end_year,
    :use_canonical
  ]

  defp format_url(word, api_key) do
    "http://api.wordnik.com/v4/word.json/#{word}/frequency?api_key=#{api_key}"
  end

  @doc """
  get frequency for requested word

  `iex> get_frequency("verbose", "SECRET_API_KEY", [:use_canonical, start_year: 1990, end_year: 2000])`

  """
  @spec get_frequency(String.t(), String.t(), frequency_params()) ::
          {:error, String.t()} | {:ok, frequency()}
  def get_frequency(word, api_key, params \\ []) do
    {fn_name, _} = __ENV__.function

    format_url(word, api_key)
    |> Formatter.Params.validate_and_fetch_query(params, @valid_params, fn_name)
  end
end
