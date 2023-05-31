defmodule Word.Etymologies do
  @moduledoc """
  etymologies for a given word

  [Wordnik Docs](https://developer.wordnik.com/docs#!/word/getEtymologies)
  """

  alias Formatter.Query

  @typedoc """
  map of optional parameters that can be passed to `get_etymologies/2` query
  """
  @type etymologies_params ::
          %{
            optional(:use_canonical) => boolean
          }

  @typedoc """
          parsed JSON response to `get_etymologies/2` query
  """
  @type etymology :: String.t()

  @valid_params [
    :use_canonical
  ]

  defp format_url(word) do
    "http://api.wordnik.com/v4/word.json/#{word}/etymologies"
  end

  @doc """
  get etymologies for requested word

  ### Parameters
  - use_canonical: boolean

  ### Example

  ```elixir
  iex> get_etymologies("verbose", [:use_canonical])
  ```

  ### Response
  `t:Word.Etymologies.etymology/0`

  ### Wordnik Docs
  https://developer.wordnik.com/docs#!/word/getEtymologies
  """
  @spec get_etymologies(String.t(), etymologies_params()) ::
          {:error, String.t()} | {:ok, etymology()}
  def get_etymologies(word, params \\ %{}) do
    {fn_name, _} = __ENV__.function

    word
    |> format_url
    |> Query.validate_and_fetch_query(params, @valid_params, fn_name)
  end
end
