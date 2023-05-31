defmodule Wordnik.Word.ScrabbleScore do
  @moduledoc """
  scrabble_score information about requested word

  [Wordnik Docs](https://developer.wordnik.com/docs#!/word/getScrabbleScore)
  """

  alias Wordnik.Formatter.Query

  @typedoc """
  parsed JSON response to `get_scrabble_score/1` query
  """
  @type scrabble_score :: integer

  defp format_url(word) do
    "http://api.wordnik.com/v4/word.json/#{word}/scrabbleScore"
  end

  @doc """
  get scrabble_score for requested word

  ### Example
  ```elixir
  iex> get_scrabble_score("verbose")
  ```

  ### Response
  `t:Word.ScrabbleScore.scrabble_score/0`

  ### Wordnik Docs
  https://developer.wordnik.com/docs#!/word/getScrabbleScore
  """
  @spec get_scrabble_score(String.t()) ::
          {:error, String.t()} | {:ok, scrabble_score()}
  def get_scrabble_score(word) do
    {fn_name, _} = __ENV__.function

    word
    |> format_url
    |> Query.validate_and_fetch_query(%{}, [], fn_name)
  end
end
