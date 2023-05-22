defmodule Word.RelatedWords do
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

  defp format_url(word, api_key) do
    "http://api.wordnik.com/v4/word.json/#{word}/relatedWords?api_key=#{api_key}"
  end

  defp format_param({:limit_per_relationship_type, limit}) when is_integer(limit), do: "limitPerRelationshipType=#{limit}"
  defp format_param({:relationship_types, types}) when is_valid_relationship_types(types), do: "relationshipTypes=#{types}"
  defp format_param(:use_canonical), do: "useCanonical=true"

  defp format_params(url, [head | tail]) do
    param = format_param(head)
    format_params(url <> "&" <> param, tail)
  end

  defp format_params(url, []), do: url

  def get_related_words(word, api_key, params \\ []) do
    resp = format_url(word, api_key)
    |> format_params(params)
    |> HTTPoison.get([], [follow_redirect: true])

    case resp do
      {:ok, content} -> {:ok, Jason.decode!(content.body)}
      {:error, _} -> resp
    end
  end
end
