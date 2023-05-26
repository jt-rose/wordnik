defmodule Word.Etymologies do
  @moduledoc false

  @valid_params [
    :use_canonical
  ]

  defp format_url(word, api_key) do
    "http://api.wordnik.com/v4/word.json/#{word}/etymologies?api_key=#{api_key}"
  end

  def get_etymologies(word, api_key, params \\ []) do
    {fn_name, _} = __ENV__.function

    format_url(word, api_key)
    |> Formatter.Params.validate_and_fetch_query(params, @valid_params, fn_name)
  end
end
