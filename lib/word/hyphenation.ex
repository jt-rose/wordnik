defmodule Word.Hyphenation do
  @moduledoc false

  @valid_params [
    :limit,
    :source_dict,
    :use_canonical
  ]

  defp format_url(word, api_key) do
    "http://api.wordnik.com/v4/word.json/#{word}/hyphenation?api_key=#{api_key}"
  end

  def get_hyphenation(word, api_key, params \\ []) do
    {fn_name, _} = __ENV__.function

    format_url(word, api_key)
    |> Formatter.Params.validate_and_fetch_query(params, @valid_params, fn_name)
  end
end
