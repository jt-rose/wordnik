defmodule Wordnik.Word.Frequency do
  @moduledoc """
  frequency of usage across years for the requested word

  [Wordnik Docs](https://developer.wordnik.com/docs#!/word/getWordFrequency)
  """
  alias Wordnik.Formatter.Query

  @typedoc """
  map of optional parameters that can be passed to `get_frequency/2` query
  """
  @type frequency_params ::
          %{
            optional(:start_year) => integer(),
            optional(:end_year) => integer(),
            optional(:use_canonical) => boolean()
          }

  @typedoc """
  parsed JSON response to `get_frequency/2` query
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
    "start_year",
    "end_year",
    "use_canonical"
  ]

  defp format_url(word) do
    "http://api.wordnik.com/v4/word.json/#{word}/frequency"
  end

  @doc """
  get frequency for requested word

  ### Parameters
  - use_canonical: boolean
  - start_year: integer
  - end_year: integer

  ### Example
  ```elixir
  iex> get_frequency("verbose", %{ use_canonical: true, start_year: 1990, end_year: 2000 })
  ```

  ### Response
  `t:Wordnik.Word.Frequency.frequency/0`

  ### Wordnik Docs
  https://developer.wordnik.com/docs#!/word/getWordFrequency
  """
  @spec get_frequency(String.t(), frequency_params()) ::
          {:error, String.t()} | {:ok, frequency()}
  def get_frequency(word, params \\ %{}) do
    {fn_name, _} = __ENV__.function

    word
    |> format_url
    |> Query.validate_and_fetch_query(params, @valid_params, fn_name)
  end
end
