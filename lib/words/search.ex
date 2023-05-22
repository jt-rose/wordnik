defmodule Words.Search do
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

  defguardp is_valid_part_of_speech(part) when part in @parts_of_speech

  defp format_url(query, api_key) do
    "http://api.wordnik.com/v4/words.json/search/#{query}?api_key=#{api_key}"
  end

  defp format_param(:allow_regex), do: "allowRegex=true"
  defp format_param(case_sensitive: sensitive) when is_boolean(sensitive), do: "caseSensitive=#{sensitive}"
  defp format_param(include_part_of_speech: part) when is_valid_part_of_speech(part), do: "includePartOfSpeech=#{part}"
  defp format_param(exclude_part_of_speech: part) when is_valid_part_of_speech(part), do: "excludePartOfSpeech=#{part}"
  defp format_param(min_corpus_count: min) when is_integer(min), do: "minCorpusCount=#{min}"
  defp format_param(max_corpus_count: max) when is_integer(max), do: "maxCorpusCount=#{max}"
  defp format_param(min_dictionary_count: min) when is_integer(min), do: "minDictionaryCount=#{min}"
  defp format_param(max_dictionary_count: max) when is_integer(max), do: "maxDictionaryCount=#{max}"
  defp format_param(min_length: min) when is_integer(min), do: "minLength=#{min}"
  defp format_param(max_length: max) when is_integer(max), do: "maxLength=#{max}"
  defp format_param(limit: limit) when is_integer(limit), do: "limit=#{limit}"
  defp format_param(skip: skip) when is_integer(skip), do: "skip=#{skip}"

  defp format_params(url, [head | tail]) do
    param = format_param(head)
    format_params(url <> "&" <> param, tail)
  end

  defp format_params(url, []), do: url

  def get_query(query, api_key, params \\ []) do
    resp = format_url(query, api_key)
    |> format_params(params)
    |> HTTPoison.get([], [follow_redirect: true])

    case resp do
      {:ok, content} -> Jason.decode!(content.body)
      {:error, _} -> resp
    end
  end
end
