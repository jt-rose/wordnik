defmodule Word.ScrabbleScore do
  @fn_name "get_scrabble_score"

  defp format_url(word, api_key) do
    "http://api.wordnik.com/v4/word.json/#{word}/scrabbleScore?api_key=#{api_key}"
  end

  def get_scrabble_score(word, api_key) do
    format_url(word, api_key)
    |> Formatter.Params.validate_and_fetch_query([], [], @fn_name)
  end
end
