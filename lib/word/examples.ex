defmodule Word.Examples do
  defp format_url(word, api_key) do
    "http://api.wordnik.com/v4/word.json/#{word}/examples?api_key=#{api_key}"
  end

  defp format_param(limit: limit) when is_integer(limit), do: "limit=#{limit}"
  defp format_param(skip: skip) when is_integer(skip), do: "skip=#{skip}"
  defp format_param(:use_canonical), do: "useCanonical=true"
  defp format_param(:include_duplicates), do: "includeDuplicates=true"

  defp format_params(url, [head | tail]) do
    param = format_param(head)
    format_params(url <> "&" <> param, tail)
  end

  defp format_params(url, []), do: url

  def get_examples(word, api_key, params \\ []) do
    resp = format_url(word, api_key)
    |> format_params(params)
    |> HTTPoison.get([], [follow_redirect: true])

    case resp do
      {:ok, content} -> Jason.decode!(content.body)
      {:error, _} -> resp
    end
  end
end
