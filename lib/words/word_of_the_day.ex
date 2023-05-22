defmodule Words.WordOfTheDay do
  defp format_url(api_key) do
    "http://api.wordnik.com/v4/words.json/wordOfTheDay?api_key=#{api_key}"
  end

  defp format_param({:date, date}), do: "date=#{date}"

  defp format_params(url, [head | tail]) do
    param = format_param(head)
    format_params(url <> "&" <> param, tail)
  end

  defp format_params(url, []), do: url

  def get_related_words(api_key, params \\ []) do
    resp = format_url(api_key)
    |> format_params(params)
    |> HTTPoison.get([], [follow_redirect: true])

    case resp do
      {:ok, content} -> Jason.decode!(content.body)
      {:error, _} -> resp
    end
  end
end
