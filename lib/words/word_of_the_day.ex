defmodule Words.WordOfTheDay do
  @valid_params [
    :date
  ]

  @fn_name "get_word_of_the_day"
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
      format_url(api_key)
      |> Formatter.Params.validate_and_fetch_query([{:date, date}], @valid_params, @fn_name)
    end
  end

  def get_word_of_the_day(api_key, [{:date, date}]) do
    {status, msg} = validate_date_format(date)

    if status == :error do
      {status, msg}
    else
      format_url(api_key)
      |> Formatter.Params.validate_and_fetch_query([{:date, date}], @valid_params, @fn_name)
    end
  end

  def get_word_of_the_day(api_key, params) do
    format_url(api_key)
    |> Formatter.Params.validate_and_fetch_query(params, @valid_params, @fn_name)
  end
end
