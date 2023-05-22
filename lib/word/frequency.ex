defmodule Word.Frequency do
  defp format_url(word, api_key) do
    "http://api.wordnik.com/v4/word.json/#{word}/frequency?api_key=#{api_key}"
  end

  defp format_param(start_year: start_year) when is_integer(start_year), do: "startYear=#{start_year}"
  defp format_param(end_year: end_year) when is_integer(end_year), do: "endYear=#{end_year}"
  defp format_param(:use_canonical), do: "useCanonical=true"

  defp format_params(url, [head | tail]) do
    param = format_param(head)
    format_params(url <> "&" <> param, tail)
  end

  defp format_params(url, []), do: url

  def get_frequency(word, api_key, params \\ []) do
    resp = format_url(word, api_key)
    |> format_params(params)
    |> HTTPoison.get([], [follow_redirect: true])

    case resp do
      {:ok, content} -> Jason.decode!(content.body)
      {:error, _} -> resp
    end
  end
end
