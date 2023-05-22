defmodule Words.RandomWords do
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

  defguardp is_valid_part_of_speech(part) when part in @parts_of_speech

  defp format_url(api_key) do
    "http://api.wordnik.com/v4/words.json/randomWords?api_key=#{api_key}"
  end

  defp format_param({:has_dictionary_def, has_def}) when is_boolean(has_def), do: "hasDictionaryDef=#{has_def}"
  defp format_param({:include_part_of_speech, part}) when is_valid_part_of_speech(part), do: "includePartOfSpeech=#{part}"
  defp format_param({:exclude_part_of_speech, part}) when is_valid_part_of_speech(part), do: "excludePartOfSpeech=#{part}"
  defp format_param({:min_corpus_count, min}) when is_integer(min), do: "minCorpusCount=#{min}"
  defp format_param({:max_corpus_count, max}) when is_integer(max), do: "maxCorpusCount=#{max}"
  defp format_param({:min_dictionary_count, min}) when is_integer(min), do: "minDictionaryCount=#{min}"
  defp format_param({:max_dictionary_count, max}) when is_integer(max), do: "maxDictionaryCount=#{max}"
  defp format_param({:min_length, min}) when is_integer(min), do: "minLength=#{min}"
  defp format_param({:max_length, max}) when is_integer(max), do: "maxLength=#{max}"
  defp format_param({:limit, limit}) when is_integer(limit), do: "limit=#{limit}"
  defp format_param({:sort_by, sort_by}) when sort_by in @sort_by, do: "sortBy=#{sort_by}"
  defp format_param({:sort_order, sort_order}) when sort_order in @sort_order, do: "sortOrder=#{sort_order}"

  defp format_params(url, [head | tail]) do
    param = format_param(head)
    format_params(url <> "&" <> param, tail)
  end

  defp format_params(url, []), do: url

  def get_random_words(api_key, params \\ []) do
    resp = format_url(api_key)
    |> format_params(params)
    |> HTTPoison.get([], [follow_redirect: true])

    case resp do
      {:ok, content} -> {:ok, Jason.decode!(content.body)}
      {:error, _} -> resp
    end
  end
end
