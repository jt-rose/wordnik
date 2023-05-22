defmodule Word.ScrabbleScore do
  defp format_url(word, api_key) do
    "http://api.wordnik.com/v4/word.json/#{word}/scrabbleScore?api_key=#{api_key}"
  end

  def get_scrabble_score(word, api_key) do
    resp = format_url(word, api_key)
    |> HTTPoison.get([], [follow_redirect: true])

    case resp do
      {:ok, content} -> {:ok, Jason.decode!(content.body)}
      {:error, _} -> resp
    end
  end
end
