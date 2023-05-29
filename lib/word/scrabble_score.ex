defmodule Word.ScrabbleScore do
  @moduledoc """
  scrabble_score information about requested word
  """

  @typedoc """
  parsed JSON response to 'get_scrabble_score' query
  """
  @type scrabble_score :: integer

  defp format_url(word) do
    "http://api.wordnik.com/v4/word.json/#{word}/scrabbleScore"
  end

  @doc """
  get scrabble_score for requested word

  `iex> get_scrabble_score("verbose")`

  """
  @spec get_scrabble_score(String.t()) ::
          {:error, String.t()} | {:ok, scrabble_score()}
  def get_scrabble_score(word) do
    {fn_name, _} = __ENV__.function

    word
    |> format_url
    |> Formatter.Params.validate_and_fetch_query([], [], fn_name)
  end
end
