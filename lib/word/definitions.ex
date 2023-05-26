defmodule Word.Definitions do
  @moduledoc false

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

  # TODO: seems too complicated, could use some refactoring
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
