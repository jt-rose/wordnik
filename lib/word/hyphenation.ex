defmodule Word.Hyphenation do
  @dictonaries [
    "all",
    "ahd-5",
    "century",
    "wiktionary",
    "webster",
    "wordnet"
  ]

  defguardp is_valid_dict(source_dict) when source_dict in @dictonaries

  defp format_url(word, api_key) do
    "http://api.wordnik.com/v4/word.json/#{word}/hyphenation?api_key=#{api_key}"
  end

  defp format_param({:limit, limit}), do: "limit=#{limit}"
  defp format_param({:source_dict, source_dict}) when is_valid_dict(source_dict), do: "sourceDictionary=#{source_dict}"
  defp format_param(:use_canonical), do: "useCanonical=true"

  defp format_params(url, [head | tail]) do
    param = format_param(head)
    format_params(url <> "&" <> param, tail)
  end

  defp format_params(url, []), do: url

  def get_hyphenation(word, api_key, params \\ []) do
    resp = format_url(word, api_key)
    |> format_params(params)
    |> HTTPoison.get([], [follow_redirect: true])

    case resp do
      {:ok, content} -> {:ok, Jason.decode!(content.body)}
      {:error, _} -> resp
    end
  end
end
