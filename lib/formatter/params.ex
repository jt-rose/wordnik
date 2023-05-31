defmodule Wordnik.Formatter.Params do
  @moduledoc false

  alias Wordnik.Helpers

  @dictonaries Helpers.get_dictionaries()

  @parts_of_speech Helpers.get_parts_of_speech()

  @sort_by Helpers.get_sort_by_options()

  @sort_order Helpers.get_sort_order_options()

  @type_format Helpers.get_type_formats()

  @relationship_types Helpers.get_relationship_types()

  defguardp is_valid_relationship_types(types) when types in @relationship_types
  defguardp is_valid_dict(source_dict) when source_dict in @dictonaries
  defguardp is_valid_part_of_speech(part) when part in @parts_of_speech
  defguardp is_valid_type_format(format) when format in @type_format

  defp format_param({:limit, limit}) when is_integer(limit), do: "limit=#{limit}"
  defp format_param({:skip, skip}) when is_integer(skip), do: "skip=#{skip}"

  defp format_param({:part_of_speech, part}) when is_valid_part_of_speech(part),
    do: "partOfSpeech=#{part}"

  defp format_param({:source_dict, source_dict}) when is_valid_dict(source_dict),
    do: "sourceDictionary=#{source_dict}"

  defp format_param({:source_dictionaries, sources}), do: "sourceDictionaries=#{sources}"

  defp format_param({:include_related, bool}), do: "includeRelated=#{bool}"
  defp format_param({:use_canonical, bool}), do: "useCanonical=#{bool}"
  defp format_param({:include_tags, bool}), do: "includeTags=#{bool}"
  defp format_param({:include_duplicates, bool}), do: "includeDuplicates=#{bool}"

  defp format_param({:start_year, start_year}) when is_integer(start_year),
    do: "startYear=#{start_year}"

  defp format_param({:end_year, end_year}) when is_integer(end_year), do: "endYear=#{end_year}"
  defp format_param({:wlmi, wlmi}) when is_integer(wlmi), do: "wlmi=#{wlmi}"

  defp format_param({:type_format, format}) when is_valid_type_format(format),
    do: "typeFormat=#{format}"

  defp format_param({:limit_per_relationship_type, limit}) when is_integer(limit),
    do: "limitPerRelationshipType=#{limit}"

  defp format_param({:relationship_types, types}) when is_valid_relationship_types(types),
    do: "relationshipTypes=#{types}"

  defp format_param({:min_corpus_count, min}) when is_integer(min), do: "minCorpusCount=#{min}"
  defp format_param({:max_corpus_count, max}) when is_integer(max), do: "maxCorpusCount=#{max}"

  defp format_param({:min_dictionary_count, min}) when is_integer(min),
    do: "minDictionaryCount=#{min}"

  defp format_param({:max_dictionary_count, max}) when is_integer(max),
    do: "maxDictionaryCount=#{max}"

  defp format_param({:min_length, min}) when is_integer(min), do: "minLength=#{min}"
  defp format_param({:max_length, max}) when is_integer(max), do: "maxLength=#{max}"

  defp format_param({:has_dictionary_def, has_def}) when is_boolean(has_def),
    do: "hasDictionaryDef=#{has_def}"

  defp format_param({:include_part_of_speech, part}) when is_valid_part_of_speech(part),
    do: "includePartOfSpeech=#{part}"

  defp format_param({:exclude_part_of_speech, part}) when is_valid_part_of_speech(part),
    do: "excludePartOfSpeech=#{part}"

  defp format_param({:sort_by, sort_by}) when sort_by in @sort_by, do: "sortBy=#{sort_by}"

  defp format_param({:sort_order, sort_order}) when sort_order in @sort_order,
    do: "sortOrder=#{sort_order}"

  defp format_param({:date, date}), do: "date=#{date}"

  # if none match, return error
  defp format_param({field, _value}), do: {:error, "field '#{field}' is not a viable parameter"}

  # update query string
  def format_params(url, [head | tail]) do
    param = format_param(head)
    format_params(url <> "&" <> param, tail)
  end

  # return fully updated query string
  def format_params(url, []), do: url

  # convert params map to list of tuples
  def standardize_params(params) when is_map(params) do
    Map.to_list(params)
  end

  # convert atoms to expected tuple with 'true' alue
  def standardize_params(params) when is_list(params) do
    Enum.map(params, &convert_atoms/1)
  end

  defp convert_atoms(item) when is_atom(item), do: {item, true}
  defp convert_atoms(item), do: item
end
