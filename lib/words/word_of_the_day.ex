defmodule Words.WordOfTheDay do
  @moduledoc """
  word of the day, searchable by date
  """
  alias Formatter.ParamTypes

  @typedoc """
  optional parameter that can be passed to 'get_word_of_the_day' query
  """
  @type word_of_the_day_param :: ParamTypes.date()

  @typedoc """
  map or list of optional parameters that can be passed to 'get_word_of_the_day' query
  """
  @type word_of_the_day_params ::
          %{
            optional(:date) => String.t()
          }
          | list(word_of_the_day_param())

  @typedoc """
  parsed JSON response to 'get_word_of_the_day' query
  """
  @type word_of_the_day ::
          %{
            _id: String.t(),
            word: String.t(),
            contentProvider: %{
              name: String.t(),
              id: integer
            },
            definitions:
              list(%{
                source: String.t(),
                text: String.t(),
                note: any,
                partOfSpeech: String.t()
              }),
            publishDate: String.t(),
            examples:
              list(%{
                url: String.t(),
                title: String.t(),
                text: String.t(),
                id: integer
              }),
            pdd: String.t(),
            note: String.t(),
            htmlExtra: any
          }

  @valid_params [
    :date
  ]

  @invalid_date_error_msg "Error: please provide a valid date in 'yyyy-MM-dd' format"

  defp format_url(api_key) do
    "http://api.wordnik.com/v4/words.json/wordOfTheDay?api_key=#{api_key}"
  end

  defp validate_date_format(date) do
    yyyy_mm_dd = ~r/^\d{4}-((0\d)|(10)|(11)|(12))-((30)|(31)|([0-2]\d))$/

    if String.match?(date, yyyy_mm_dd) do
      invalid_feb_dates = ~r/^\d{4}-02-((30)|(31))$/

      if String.match?(date, invalid_feb_dates) do
        {:error, @invalid_date_error_msg}
      else
        {:ok, "valid date format"}
      end
    else
      {:error, @invalid_date_error_msg}
    end
  end

  def get_word_of_the_day(api_key, params \\ [])

  def get_word_of_the_day(api_key, %{"date" => date}) do
    {status, msg} = validate_date_format(date)

    if status == :error do
      {status, msg}
    else
      {fn_name, _} = __ENV__.function

      format_url(api_key)
      |> Formatter.Params.validate_and_fetch_query([{:date, date}], @valid_params, fn_name)
    end
  end

  def get_word_of_the_day(api_key, [{:date, date}]) do
    {status, msg} = validate_date_format(date)

    if status == :error do
      {status, msg}
    else
      {fn_name, _} = __ENV__.function

      format_url(api_key)
      |> Formatter.Params.validate_and_fetch_query([{:date, date}], @valid_params, fn_name)
    end
  end

  @doc """
  get word_of_the_day for requested word

  `get_word_of_the_day("SECRET_KEY", [date: "1985-12-31"])`

  """
  @spec get_word_of_the_day(String.t(), word_of_the_day_params()) ::
          {:error, String.t()} | {:ok, word_of_the_day()}
  def get_word_of_the_day(api_key, params) do
    {fn_name, _} = __ENV__.function

    format_url(api_key)
    |> Formatter.Params.validate_and_fetch_query(params, @valid_params, fn_name)
  end
end
