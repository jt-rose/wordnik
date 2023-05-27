defmodule Word.ScrabbleScore do
  @moduledoc """
  scrabble_score information about requested word
  """

  @typedoc """
  parsed JSON response to 'get_scrabble_score' query
  """
  @type scrabble_score :: integer

  defp format_url(word, api_key) do
    "http://api.wordnik.com/v4/word.json/#{word}/scrabbleScore?api_key=#{api_key}"
  end

  @doc """
  get scrabble_score for requested word

  `get_scrabble_score("verbose", "SECRET_KEY")`

  """
  @spec get_scrabble_score(String.t(), String.t()) ::
          {:error, String.t()} | {:ok, scrabble_score()}
  def get_scrabble_score(word, api_key) do
    {fn_name, _} = __ENV__.function

    format_url(word, api_key)
    |> Formatter.Params.validate_and_fetch_query([], [], fn_name)
  end
end
