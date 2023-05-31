defmodule Wordnik.Word.TopExample do
  @moduledoc """
  find top-rated example for requested word

  [Wordnik Docs](https://developer.wordnik.com/docs#!/word/getTopExample)
  """
  alias Wordnik.Formatter.Query

  @typedoc """
  map of optional parameters that can be passed to `get_top_example/2` query
  """
  @type top_example_params ::
          %{
            optional(:use_canonical) => boolean()
          }

  @valid_params [
    "use_canonical"
  ]

  defp format_url(word) do
    "http://api.wordnik.com/v4/word.json/#{word}/topExample"
  end

  @doc """
  get top_example for requested word

  ### Parameters
  - use_canonical: boolean

  ### Example
  ```elixir
  iex> get_top_example("verbose", %{use_canonical: true})
  ```

  ### Response
  `t:Word.Examples.example/0`

  ### Wordnik Docs
  https://developer.wordnik.com/docs#!/word/getTopExample
  """
  @spec get_top_example(String.t(), top_example_params()) ::
          {:error, String.t()} | {:ok, Word.Examples.example()}
  def get_top_example(word, params \\ %{}) do
    {fn_name, _} = __ENV__.function

    word
    |> format_url
    |> Query.validate_and_fetch_query(params, @valid_params, fn_name)
  end
end
