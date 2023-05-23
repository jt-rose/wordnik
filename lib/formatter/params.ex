defmodule Formatter.Params do

  @dictonaries [
    "all",
    "ahd-5",
    "century",
    "wiktionary",
    "webster",
    "wordnet"
  ]

  @source_dictionaries [
    "ahd-5",
    "century",
    "cmu",
    "macmillan",
    "wiktionary",
    "webster",
    "wordnet"
  ]

  @parts_of_speech [
    "noun",
    "adjective",
    "verb",
    "adverb",
    "interjection",
    "pronoun",
    "preposition",
    "abbreviation",
    "affix",
    "article",
    "auxiliary-verb",
    "conjunction",
    "definite-article",
    "family-name",
    "given-name",
    "idiom",
    "imperative",
    "noun-plural",
    "noun-posessive",
    "past-participle",
    "phrasal-prefix",
    "proper-noun",
    "proper-noun-plural",
    "proper-noun-posessive",
    "suffix",
    "verb-intransitive",
    "verb-transitive"
  ]

  @sort_by [
    "alpha",
    "count"
  ]

  @sort_order [
    "asc",
    "desc"
  ]

  @type_format [
    "ahd-5",
    "arpabet",
    "gcide-diacritical",
    "IPA"
  ]

  @relationship_types [
    "synonym",
    "antonym",
    "variant",
    "equivalent",
    "cross-reference",
    "related-word",
    "rhyme",
    "form",
    "etymologically-related-term",
    "hypernym",
    "hyponym",
    "inflected-form",
    "primary",
    "same-context",
    "verb-form",
    "verb-stem",
    "has-topic"
  ]

  defguardp is_valid_relationship_types(types) when types in @relationship_types
  defguardp is_valid_dict(source_dict) when source_dict in @dictonaries
  defguardp is_valid_part_of_speech(part) when part in @parts_of_speech
  defguardp is_valid_type_format(format) when format in @type_format

  defp format_param({:limit, limit}) when is_integer(limit), do: "limit=#{limit}"
  defp format_param({:skip, skip}) when is_integer(skip), do: "skip=#{skip}"
  defp format_param({:part_of_speech, part}) when is_valid_part_of_speech(part), do: "partOfSpeech=#{part}"
  defp format_param({:source_dict, source_dict}) when is_valid_dict(source_dict), do: "sourceDictionary=#{source_dict}"
  defp format_param({:include_related, bool}), do: "includeRelated=#{bool}"
  defp format_param({:use_canonical, bool}), do: "useCanonical=#{bool}"
  defp format_param({:include_tags, bool}), do: "includeTags=#{bool}"
  defp format_param({:include_duplicates, bool}), do: "includeDuplicates=#{bool}"
  defp format_param({:start_year, start_year}) when is_integer(start_year), do: "startYear=#{start_year}"
  defp format_param({:end_year, end_year}) when is_integer(end_year), do: "endYear=#{end_year}"
  defp format_param({:wlmi, wlmi}) when is_integer(wlmi), do: "wlmi=#{wlmi}"
  defp format_param({:type_format, format}) when is_valid_type_format(format), do: "typeFormat=#{format}"
  defp format_param({:limit_per_relationship_type, limit}) when is_integer(limit), do: "limitPerRelationshipType=#{limit}"
  defp format_param({:relationship_types, types}) when is_valid_relationship_types(types), do: "relationshipTypes=#{types}"
  defp format_param({:min_corpus_count, min}) when is_integer(min), do: "minCorpusCount=#{min}"
  defp format_param({:max_corpus_count, max}) when is_integer(max), do: "maxCorpusCount=#{max}"
  defp format_param({:min_dictionary_count, min}) when is_integer(min), do: "minDictionaryCount=#{min}"
  defp format_param({:max_dictionary_count, max}) when is_integer(max), do: "maxDictionaryCount=#{max}"
  defp format_param({:min_length, min}) when is_integer(min), do: "minLength=#{min}"
  defp format_param({:max_length, max}) when is_integer(max), do: "maxLength=#{max}"
  defp format_param({:has_dictionary_def, has_def}) when is_boolean(has_def), do: "hasDictionaryDef=#{has_def}"
  defp format_param({:include_part_of_speech, part}) when is_valid_part_of_speech(part), do: "includePartOfSpeech=#{part}"
  defp format_param({:exclude_part_of_speech, part}) when is_valid_part_of_speech(part), do: "excludePartOfSpeech=#{part}"
  defp format_param({:sort_by, sort_by}) when sort_by in @sort_by, do: "sortBy=#{sort_by}"
  defp format_param({:sort_order, sort_order}) when sort_order in @sort_order, do: "sortOrder=#{sort_order}"
  defp format_param({:find_sense_for_word, sense}), do: "findSenseForWord=#{sense}"
  defp format_param({:expand_terms, query}), do: "expandTerms=#{query}"
  defp format_param({:allow_regex, bool}), do: "allowRegex=#{bool}"
  defp format_param({:case_sensitive, sensitive}) when is_boolean(sensitive), do: "caseSensitive=#{sensitive}"
  defp format_param({:date, date}), do: "date=#{date}"

  defp format_param({:include_source_dictionaries, sources}) do
    validate_sources(sources)
    "includeSourceDictionaries=#{sources}"
  end

  defp format_param({:exclude_source_dictionaries, sources}) do
    validate_sources(sources)
    "excludeSourceDictionaries=#{sources}"
  end

  # if none match, return error
  defp format_param({field, _value}), do: {:error, "field '#{field}' is not a viable parameter"}

  defp validate_source_dict(dict) when dict in @source_dictionaries, do: dict
  defp validate_sources(sources) do
    sources
    |> String.split(",")
    |> Enum.filter(fn(str) -> str != "" end)
    |> Enum.map(&validate_source_dict/1)

    sources
  end

  # update query string
  defp format_params(url, [head | tail]) do
    param = format_param(head)
    format_params(url <> "&" <> param, tail)
  end

  # return fully updated query string
  defp format_params(url, []), do: url

  # convert params map to list of tuples
  defp standardize_params(params) when is_map(params) do
    Map.to_list(params)
  end

  # convert atoms to expected tuple with 'true' alue
  defp standardize_params(params) when is_list(params) do
    Enum.map(params, &convert_atoms/1)
  end

  defp convert_atoms(item) when is_atom(item), do: {item, true}
  defp convert_atoms(item), do: item

  # validate params against accepted list of parameters
  defp validate_params(params, valid_list, fn_name) do
    invalid_param = params
    |> Enum.map(fn({name, _}) -> name end)
    |> Enum.find(fn(name) -> name not in valid_list end)

    if invalid_param == nil do
      {:ok, params}
    else
      {:error, "'#{invalid_param}' not a valid parameter for the '#{fn_name}' function"}
    end
  end

  # fetch formatted query and decode if success
  defp fetch_query({:ok, fmt_params}, url) do
    # format query string and fetch data
    resp = url
    |> format_params(fmt_params)
    |> HTTPoison.get([], [follow_redirect: true])

    # return decoded response or error
    case resp do
      {:ok, content} -> {:ok, Jason.decode!(content.body)}
      {:error, _} -> resp
    end
  end

  # return error tuple if invalid parameter provided
  defp fetch_query({:error, msg }, _url) do
    {:error, msg}
  end


  # validate, format, and run query
  def validate_and_fetch_query(url, params, valid_params, fn_name) do
    params
    |> standardize_params
    |> validate_params(valid_params, fn_name)
    |> fetch_query(url)
  end
end
