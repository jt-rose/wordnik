defmodule Word.Definitions do
  alias HTTPoison

  @dictonaries [
    "all",
    "ahd-5",
    "century",
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

  defguardp is_valid_dict(source_dict) when source_dict in @dictonaries
  defguardp is_valid_part_of_speech(part) when part in @parts_of_speech

  defp format_url(word, api_key) do
    "http://api.wordnik.com/v4/word.json/#{word}/definitions?api_key=#{api_key}"
  end

  # defp format_param(limit: limit) when is_integer(limit), do: "limit=#{limit}"
  defp format_param(part_of_speech: part) when is_valid_part_of_speech(part), do: "partOfSpeech=#{part}"
  defp format_param(source_dict: source_dict) when is_valid_dict(source_dict), do: "sourceDictionary=#{source_dict}"
  defp format_param(:include_related), do: "includeRelated=true"
  defp format_param(:use_canonical), do: "useCanonical=true"
  defp format_param(:include_tags), do: "includeTags=true"

  defp format_params(url, [head | tail]) do
    param = format_param(head)
    format_params(url <> "&" <> param, tail)
  end

  defp format_params(url, []), do: url

  def get_definitions(word, api_key, params \\ []) do
    resp = format_url(word, api_key)
    |> format_params(params)
    |> HTTPoison.get([], [follow_redirect: true])

    case resp do
      {:ok, content} -> Jason.decode!(content.body)
      {:error, _} -> resp
    end
  end
end
