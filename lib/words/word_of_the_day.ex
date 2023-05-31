defmodule Wordnik.Words.WordOfTheDay do
  @moduledoc """
  word of the day, searchable by date

  [Wordnik Docs](https://developer.wordnik.com/docs#!/words/getWordOfTheDay)
  """
  alias Wordnik.Formatter.Query

  @typedoc """
  map of optional parameters that can be passed to `get_word_of_the_day/1` query
  """
  @type word_of_the_day_params ::
          %{
            optional(:date) => Formatter.Enums.date()
          }

  @typedoc """
  parsed JSON response to `get_word_of_the_day/1` query
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

  def get_word_of_the_day(params \\ %{})

  def get_word_of_the_day(%{date: date}) do
    {status, msg} = validate_date_format(date)

    if status == :error do
      {status, msg}
    else
      {fn_name, _} = __ENV__.function

      Query.validate_and_fetch_query(
        "http://api.wordnik.com/v4/words.json/wordOfTheDay",
        [{:date, date}],
        @valid_params,
        fn_name
      )
    end
  end

  @doc """
  get word_of_the_day for requested word

  ### Parameters
  - date: string

  ### Example
  ```elixir
  iex> get_word_of_the_day("SECRET_API_KEY", %{date: "1985-12-31"})
  ```

  ### Response
  `t:Words.WordOfTheDay.word_of_the_day/0`

  ### Wordnik Docs
  https://developer.wordnik.com/docs#!/word/getWordOfTheDay
  """
  @spec get_word_of_the_day(word_of_the_day_params()) ::
          {:error, String.t()} | {:ok, word_of_the_day()}
  def get_word_of_the_day(params) do
    {fn_name, _} = __ENV__.function

    Query.validate_and_fetch_query(
      "http://api.wordnik.com/v4/words.json/wordOfTheDay",
      params,
      @valid_params,
      fn_name
    )
  end
end
