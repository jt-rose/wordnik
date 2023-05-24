defmodule Word.Examples do
  @valid_params [
    :limit,
    :skip,
    :use_canonical,
    :include_duplicates
  ]

  @fn_name "get_examples"

  defp format_url(word, api_key) do
    "http://api.wordnik.com/v4/word.json/#{word}/examples?api_key=#{api_key}"
  end

  def get_examples(word, api_key, params \\ []) do
    format_url(word, api_key)
    |> Formatter.Params.validate_and_fetch_query(params, @valid_params, @fn_name)
  end
end
