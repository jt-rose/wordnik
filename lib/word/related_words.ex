defmodule Word.RelatedWords do
  @moduledoc """
  find related words organized by type of relationship (synonym, antonym, etc.)
  """
  alias Formatter.ParamTypes

  @typedoc """
  optional parameter that can be passed to `get_related_words/2` query
  """
  @type related_words_param ::
          ParamTypes.use_canonical() | ParamTypes.limit() | ParamTypes.relationship_types()

  @typedoc """
  map or list of optional parameters that can be passed to `get_related_words/2` query
  """
  @type related_words_params ::
          %{
            optional(:use_canonical) => boolean(),
            optional(:limit) => integer(),
            optional(:relationship_types) => String.t()
          }
          | list(related_words_param())

  @typedoc """
  parsed JSON response to `get_related_words/2` query
  """
  @type related_words ::
          list(%{
            relationshipType: String.t(),
            words: list(String.t())
          })

  @valid_params [
    :limit,
    :relationship_types,
    :use_canonical
  ]

  defp format_url(word) do
    "http://api.wordnik.com/v4/word.json/#{word}/relatedWords"
  end

  @doc """
  get related_words for requested word

  ### Parameters
  - use_canonical: boolean
  - limit: integer
  - relationship_types: string

  ### Example

  ```elixir
  iex> get_related_words("verbose", [:use_canonical, relationship_types: "synonym"])
  ```

  ### Wordnik Docs

  https://developer.wordnik.com/docs#!/word/getRelatedWords
  """
  @spec get_related_words(String.t(), related_words_params()) ::
          {:error, String.t()} | {:ok, related_words()}
  def get_related_words(word, params \\ []) do
    {fn_name, _} = __ENV__.function

    word
    |> format_url
    |> Formatter.Params.validate_and_fetch_query(params, @valid_params, fn_name)
  end
end
