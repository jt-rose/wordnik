defmodule Wordnik.Word.Audio do
  @moduledoc """
  audio information about requested word, including link to audio recording

  [Wordnik Docs](https://developer.wordnik.com/docs#!/word/getAudio)
  """

  alias Wordnik.Formatter.Query

  @typedoc """
  map of optional parameters that can be passed to `get_audio/2` query
  """
  @type audio_params ::
          %{
            optional(:limit) => integer(),
            optional(:use_canonical) => boolean()
          }

  @typedoc """
  parsed JSON response to `get_audio/2` query
  """
  @type audio ::
          list(%{
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
          })

  @valid_params [
    "limit",
    "use_canonical"
  ]

  defp format_url(word) do
    "http://api.wordnik.com/v4/word.json/#{word}/audio"
  end

  @doc """
  get audio information for requested word, including link to recording

  ### Parameters
  - limit: integer
  - use_canonical: boolean

  ### Example
  ```elixir
  iex> get_audio("Havana", %{use_canonical: true, limit: 5})
  ```

  ### Response
  `t:Word.Audio.audio/0`

  ### Wordnik Docs
  https://developer.wordnik.com/docs#!/word/getAudio
  """
  @spec get_audio(String.t(), audio_params()) ::
          {:error, String.t()} | {:ok, audio}
  def get_audio(word, params \\ %{}) do
    {fn_name, _} = __ENV__.function

    word
    |> format_url
    |> Query.validate_and_fetch_query(params, @valid_params, fn_name)
  end
end
