defmodule Word.RelatedWords do
  @moduledoc false

  @valid_params [
    :limit,
    :relationship_types,
    :use_canonical
  ]

  defp format_url(word, api_key) do
    "http://api.wordnik.com/v4/word.json/#{word}/relatedWords?api_key=#{api_key}"
  end

  def get_related_words(word, api_key, params \\ []) do
    {fn_name, _} = __ENV__.function

    format_url(word, api_key)
    |> Formatter.Params.validate_and_fetch_query(params, @valid_params, fn_name)
  end
end
