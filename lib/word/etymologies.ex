defmodule Word.Etymologies do
  @valid_params [
    :use_canonical
  ]

  @fn_name "get_etymologies"

  defp format_url(word, api_key) do
    "http://api.wordnik.com/v4/word.json/#{word}/etymologies?api_key=#{api_key}"
  end

  # defp format_param(:use_canonical), do: "useCanonical=true"

  # defp format_params(url, [head | tail]) do
  #   param = format_param(head)
  #   format_params(url <> "&" <> param, tail)
  # end

  # defp format_params(url, []), do: url

  def get_etymologies(word, api_key, params \\ []) do
    format_url(word, api_key)
    |> Formatter.Params.validate_and_fetch_query(params, @valid_params, @fn_name)

    # resp = format_url(word, api_key)
    # |> format_params(params)
    # |> HTTPoison.get([], [follow_redirect: true])

    # case resp do
    #   {:ok, content} -> {:ok, Jason.decode!(content.body)}
    #   {:error, _} -> resp
    # end
  end
end
