defmodule Word.Definitions do
  @moduledoc """
  word definition(s) across various dictionaries
  """

  alias Formatter.ParamTypes

  @typedoc """
  optional parameter that can be passed to 'get_definitions' query
  """
  @type definitions_param ::
          ParamTypes.use_canonical()
          | ParamTypes.include_related()
          | ParamTypes.include_tags()
          | ParamTypes.limit()
          | ParamTypes.part_of_speech()
          | ParamTypes.source_dictionaries()

  @typedoc """
  map or list of optional parameters that can be passed to 'get_definitions' query
  """
  @type definitions_params ::
          %{
            optional(:use_canonical) => boolean,
            optional(:include_related) => boolean,
            optional(:include_tags) => boolean,
            optional(:limit) => integer,
            optional(:part_of_speech) => String.t(),
            optional(:source_dictionaries) => String.t()
          }
          | list(definitions_param())

  @typedoc """
          parsed JSON response to 'get_definitions' query
  """
  @type definition ::
          %{
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
          }

  @valid_params [
    :limit,
    :part_of_speech,
    :source_dictionaries,
    :include_related,
    :use_canonical,
    :include_tags
  ]

  defp format_url(word, api_key) do
    "http://api.wordnik.com/v4/word.json/#{word}/definitions?api_key=#{api_key}"
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

  `get_definitions("verbose", "SECRET_KEY", [part_of_speech: "noun", limit: 5])`

  """
  @spec get_definitions(String.t(), String.t(), definitions_params()) ::
          {:error, String.t()} | {:ok, list(definition)}
  def get_definitions(word, api_key, params \\ []) do
    if !has_valid_source_dictionaries?(params) do
      {:error,
       "Invalid source dictionaries provided. Provide 'all', a single dictionary, or a comma-separated list of dictionaries excluding 'all'."}
    else
      {fn_name, _} = __ENV__.function

      format_url(word, api_key)
      |> Formatter.Params.validate_and_fetch_query(params, @valid_params, fn_name)
    end
  end
end
