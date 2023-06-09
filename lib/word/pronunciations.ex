defmodule Wordnik.Word.Pronunciations do
  @moduledoc """
  pronunciation information for requested word

  [Wordnik Docs](https://developer.wordnik.com/docs#!/word/getTextPronunciations)
  """
  alias Wordnik.Formatter.Query

  @typedoc """
  map of optional parameters that can be passed to `get_pronunciations/2` query
  """
  @type pronunciations_params ::
          %{
            optional(:use_canonical) => boolean(),
            optional(:limit) => integer(),
            optional(:source_dict) => Formatter.Enums.source_dict(),
            optional(:type_format) => Formatter.Enums.type_format()
          }

  @typedoc """
  parsed JSON response to `get_pronunciations/2` query
  """
  @type pronunciations ::
          list(%{
            optional(:id) => String.t(),
            optional(:attributionText) => String.t(),
            optional(:attributionUrl) => String.t(),
            seq: integer,
            raw: String.t(),
            rawType: String.t()
          })

  @valid_params [
    "limit",
    "type_format",
    "source_dict",
    "use_canonical"
  ]

  defp format_url(word) do
    "http://api.wordnik.com/v4/word.json/#{word}/definitions"
  end

  @doc """
  get pronunciations for requested word

  ### Parameters
  - use_canonical: boolean
  - limit: integer
  - type_format: string
  - source_dict: string

  ### Example
  ```elixir
  iex> get_pronunciations("verbose", %{use_canonical: true, limit: 5})
  ```

  ### Response
  `t:Wordnik.Word.Pronunciations.pronunciations/0`

  ### Wordnik Docs
  https://developer.wordnik.com/docs#!/word/getTextPronunciations
  """
  @spec get_pronunciations(String.t(), pronunciations_params()) ::
          {:error, String.t()} | {:ok, pronunciations()}
  def get_pronunciations(word, params \\ %{}) do
    {fn_name, _} = __ENV__.function

    word
    |> format_url
    |> Query.validate_and_fetch_query(params, @valid_params, fn_name)
  end
end
