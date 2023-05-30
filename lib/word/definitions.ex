defmodule Word.Definitions do
  @moduledoc """
  word definition(s) across various dictionaries
  """

  alias Formatter.Query

  @typedoc """
  map or list of optional parameters that can be passed to `get_definitions/2` query
  """
  @type definitions_params ::
          %{
            optional(:use_canonical) => boolean,
            optional(:include_related) => boolean,
            optional(:include_tags) => boolean,
            optional(:limit) => integer,
            optional(:part_of_speech) => Formatter.Enums.part_of_speech(),
            optional(:source_dictionaries) => Formatter.Enums.source_dictionaries()
          }

  @typedoc """
          parsed JSON response to `get_definitions/2` query
  """
  @type definitions ::
          list(%{
            attributionText: String.t(),
            attributionUrl: String.t(),
            citations: [
              any
            ],
            exampleUses: [
              any
            ],
            extendedText: String.t(),
            labels: [
              any
            ],
            notes: [
              any
            ],
            partOfSpeech: String.t(),
            relatedWords: [
              any
            ],
            score: integer,
            seqString: String.t(),
            sequence: String.t(),
            sourceDictionary: String.t(),
            text: String.t(),
            textProns: [
              any
            ],
            word: String.t()
          })

  @valid_params [
    :limit,
    :part_of_speech,
    :source_dictionaries,
    :include_related,
    :use_canonical,
    :include_tags
  ]

  defp format_url(word) do
    "http://api.wordnik.com/v4/word.json/#{word}/definitions"
  end

  defp has_source_dictionaries_field?({:source_dictionaries, _dicts}), do: true
  defp has_source_dictionaries_field?(_), do: false

  defp has_valid_source_dictionaries?(params) do
    if is_map(params) and Map.has_key?(params, "source_dictionaries") do
      Formatter.Validator.has_valid_sources?(params["source_dictionaries"])
    else
      sources = Enum.find(params, &has_source_dictionaries_field?/1)

      if sources != nil do
        {_, dicts} = sources
        Formatter.Validator.has_valid_sources?(dicts)
      else
        true
      end
    end
  end

  @doc """
  get definition(s) for requested word

  ### Parameters
  - use_canonical: boolean
  - include_related: boolean
  - include_tags: boolean
  - limit: integer
  - part_of_speech: string
  - source_dictionaries: string

  ### Example
  ```elixir
  iex> get_definitions("verbose", %{part_of_speech: "noun", limit: 5})
  ```

  ### Response
  `t:Word.Definitions.definitions/0`

  ### Wordnik Docs
  https://developer.wordnik.com/docs#!/word/getDefinitions
  """
  @spec get_definitions(String.t(), definitions_params()) ::
          {:error, String.t()} | {:ok, definitions}
  def get_definitions(word, params \\ %{}) do
    if !has_valid_source_dictionaries?(params) do
      {:error,
       "Invalid source dictionaries provided. Provide 'all', a single dictionary, or a comma-separated list of dictionaries excluding 'all'."}
    else
      {fn_name, _} = __ENV__.function

      word
      |> format_url
      |> Query.validate_and_fetch_query(params, @valid_params, fn_name)
    end
  end
end
