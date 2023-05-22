defmodule Word.Pronunciations do
  @dictonaries [
    "all",
    "ahd-5",
    "century",
    "wiktionary",
    "webster",
    "wordnet"
  ]

  @type_format [
    "ahd-5",
    "arpabet",
    "gcide-diacritical",
    "IPA"
  ]

  defguardp is_valid_dict(source_dict) when source_dict in @dictonaries
  defguardp is_valid_type_format(format) when format in @type_format

  defp format_url(word, api_key) do
    "http://api.wordnik.com/v4/word.json/#{word}/definitions?api_key=#{api_key}"
  end

  defp format_param(limit: limit) when is_integer(limit), do: "limit=#{limit}"
  defp format_param(type_format: format) when is_valid_type_format(format), do: "typeFormat=#{format}"
  defp format_param(source_dict: source_dict) when is_valid_dict(source_dict), do: "sourceDictionary=#{source_dict}"
  defp format_param(:use_canonical), do: "useCanonical=true"

  defp format_params(url, [head | tail]) do
    param = format_param(head)
    format_params(url <> "&" <> param, tail)
  end

  defp format_params(url, []), do: url

  def get_pronunciations(word, api_key, params \\ []) do
    resp = format_url(word, api_key)
    |> format_params(params)
    |> HTTPoison.get([], [follow_redirect: true])

    case resp do
      {:ok, content} -> Jason.decode!(content.body)
      {:error, _} -> resp
    end
  end
end
