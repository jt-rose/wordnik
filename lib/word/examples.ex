defmodule Wordnik.Word.Examples do
  @moduledoc """
  examples for a given word

  [Wordnik Docs](https://developer.wordnik.com/docs#!/word/getExamples)
  """

  alias Wordnik.Formatter.Query

  @typedoc """
  map of optional parameters that can be passed to `get_examples/2` query
  """
  @type examples_params ::
          %{
            optional(:use_canonical) => boolean,
            optional(:include_duplicates) => boolean,
            optional(:limit) => integer,
            optional(:skip) => integer
          }

  @typedoc """
          parsed JSON response to `get_examples/2` query
  """

  @type example :: %{
          provider: %{
            id: integer
          },
          year: integer,
          rating: integer,
          url: String.t(),
          word: String.t(),
          text: String.t(),
          documentId: integer,
          exampleId: integer,
          title: String.t()
        }

  @type examples :: %{
          examples: list(example())
        }

  @valid_params [
    :limit,
    :skip,
    :use_canonical,
    :include_duplicates
  ]

  defp format_url(word) do
    "http://api.wordnik.com/v4/word.json/#{word}/examples"
  end

  @doc """
  get examples for requested word

  ### Parameters
  - use_canonical: boolean
  - include_duplicates: boolean
  - limit: integer
  - skip: integer

  ### Example
  ```elixir
  iex> get_examples("verbose", %{use_canonical: true, limit: 5})
  ```

  ### Response
  `t:Word.Examples.examples/0`

  ### Wordnik Docs
  https://developer.wordnik.com/docs#!/word/getExamples
  """
  @spec get_examples(String.t(), examples_params()) ::
          {:error, String.t()} | {:ok, examples()}
  def get_examples(word, params \\ %{}) do
    {fn_name, _} = __ENV__.function

    word
    |> format_url
    |> Query.validate_and_fetch_query(params, @valid_params, fn_name)
  end
end
