defmodule Word.TopExample do
  @valid_params [
    :use_canonical
  ]

  @fn_name "get_top_example"

  defp format_url(word, api_key) do
    "http://api.wordnik.com/v4/word.json/#{word}/topExample?api_key=#{api_key}"
  end

  def get_top_example(word, api_key, params \\ []) do
    format_url(word, api_key)
    |> Formatter.Params.validate_and_fetch_query(params, @valid_params, @fn_name)
  end
end
