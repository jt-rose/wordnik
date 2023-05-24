defmodule Word.Phrases do
  @valid_params [
    :limit,
    :wlmi,
    :use_canonical
  ]

  @fn_name "get_phrases"

  defp format_url(word, api_key) do
    "http://api.wordnik.com/v4/word.json/#{word}/phrases?api_key=#{api_key}"
  end

  def get_phrases(word, api_key, params \\ []) do
    format_url(word, api_key)
    |> Formatter.Params.validate_and_fetch_query(params, @valid_params, @fn_name)
  end
end
