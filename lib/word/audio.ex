defmodule Word.Audio do
  @moduledoc """
  audio information about requested word, including link to audio recording
  """

  @typedoc """
  optional parameter that can be passed to 'get_audio' query
  """
  @type audio_param :: {:limit, integer} | :use_canonical | {:use_canonical, boolean()}

  @typedoc """
  map or list of optional parameters that can be passed to 'get_audio' query
  """
  @type audio_params ::
          %{
            optional(:limit) => integer(),
            optional(:use_canonical) => boolean()
          }
          | list(audio_param())

  @typedoc """
  parsed JSON response to 'get_audio' query
  """
  @type audio_response :: %{
          attributionText: String.t(),
          attributionUrl: String.t(),
          audioType: String.t(),
          commentCount: integer,
          createdAt: String.t(),
          createdBy: String.t(),
          description: String.t(),
          duration: integer,
          fileUrl: String.t(),
          id: integer,
          voteAverage: integer,
          voteCount: integer,
          voteWeightedAverage: integer,
          word: String.t()
        }

  @valid_params [
    :limit,
    :use_canonical
  ]

  defp format_url(word, api_key) do
    "http://api.wordnik.com/v4/word.json/#{word}/audio?api_key=#{api_key}"
  end

  @doc """
  get audio information for requested word, including link to recording

  `get_audio("Havana", "SECRET_KEY", [:use_canonical, limit: 5])`

  """
  @spec get_audio(String.t(), String.t(), audio_params()) ::
          {:error, String.t()} | {:ok, audio_response()}
  def get_audio(word, api_key, params \\ []) do
    {fn_name, _} = __ENV__.function

    format_url(word, api_key)
    |> Formatter.Params.validate_and_fetch_query(params, @valid_params, fn_name)
  end
end
