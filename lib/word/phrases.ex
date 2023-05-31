defmodule Wordnik.Word.Phrases do
  @moduledoc """
  phrases that include the selected word

  [Wordnik Docs](https://developer.wordnik.com/docs#!/word/getPhrases)
  """
  alias Wordnik.Formatter.Query

  @typedoc """
  map of optional parameters that can be passed to `get_phrases/2` query
  """
  @type phrases_params ::
          %{
            optional(:use_canonical) => boolean(),
            optional(:limit) => integer(),
            optional(:wlmi) => integer()
          }

  @typedoc """
  parsed JSON response to `get_phrases/2` query
  """
  @type phrases ::
          list(%{
            count: integer,
            gram1: String.t(),
            gram2: String.t(),
            mi: integer,
            wlmi: integer
          })

  @valid_params [
    "limit",
    "wlmi",
    "use_canonical"
  ]

  defp format_url(word) do
    "http://api.wordnik.com/v4/word.json/#{word}/phrases"
  end

  @doc """
  get phrases for requested word

  ### Parameters
  - use_canonical: boolean
  - limit: integer
  - wlmi: string

  ### Example
  ```elixir
  iex> get_phrases("verbose", %{use_canonical: true, limit: 5})
  ```

  ### Response
  `t:Word.Phrases.phrases/0`

  ### Wordnik Docs
  https://developer.wordnik.com/docs#!/word/getPhrases
  """
  @spec get_phrases(String.t(), phrases_params()) ::
          {:error, String.t()} | {:ok, phrases()}
  def get_phrases(word, params \\ %{}) do
    {fn_name, _} = __ENV__.function

    word
    |> format_url
    |> Query.validate_and_fetch_query(params, @valid_params, fn_name)
  end
end
