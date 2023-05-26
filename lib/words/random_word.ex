defmodule Words.RandomWord do
  @valid_params [
    :has_dictionary_def,
    :include_part_of_speech,
    :exclude_part_of_speech,
    :min_corpus_count,
    :max_corpus_count,
    :min_dictionary_count,
    :max_dictionary_count,
    :min_length,
    :max_length
  ]

  defp format_url(api_key) do
    "http://api.wordnik.com/v4/words.json/randomWord?api_key=#{api_key}"
  end

  def get_random_word(api_key, params \\ []) do
    {fn_name, _} = __ENV__.function

    format_url(api_key)
    |> Formatter.Params.validate_and_fetch_query(params, @valid_params, fn_name)
  end
end
