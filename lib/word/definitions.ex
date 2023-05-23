defmodule Word.Definitions do
  @valid_params [
    :limit,
    :part_of_speech,
    :source_dict,
    :include_related,
    :use_canonical,
    :include_tags
  ]

  @fn_name "get_definitions"

  defp format_url(word, api_key) do
    "http://api.wordnik.com/v4/word.json/#{word}/definitions?api_key=#{api_key}"
  end

  def get_definitions(word, api_key, params \\ []) do
    format_url(word, api_key)
    |> Formatter.Params.validate_and_fetch_query(params, @valid_params, @fn_name)
  end
end
