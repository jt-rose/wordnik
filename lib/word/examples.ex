defmodule Word.Examples do
  @moduledoc """
  examples for a given word
  """

  alias Formatter.ParamTypes

  @typedoc """
  optional parameter that can be passed to 'get_examples' query
  """
  @type examples_param ::
          ParamTypes.use_canonical()
          | ParamTypes.include_duplicates()
          | ParamTypes.limit()
          | ParamTypes.skip()

  @typedoc """
  map or list of optional parameters that can be passed to 'get_examples' query
  """
  @type examples_params ::
          %{
            optional(:use_canonical) => boolean,
            optional(:include_duplicates) => boolean,
            optional(:limit) => integer,
            optional(:skip) => integer
          }
          | list(examples_param())

  @typedoc """
          parsed JSON response to 'get_examples' query
  """
  @type example :: %{
          examples:
            list(%{
              provider: %{
                id: integer
              },
              year: integer,
              rating: integer,
              url: String.t(),
              word: String.t(),
              text: String.t(),
              documentId: integer,
              exampleId: integer,
              title: String.t()
            })
        }

  @valid_params [
    :limit,
    :skip,
    :use_canonical,
    :include_duplicates
  ]

  defp format_url(word, api_key) do
    "http://api.wordnik.com/v4/word.json/#{word}/examples?api_key=#{api_key}"
  end

  @doc """
  get examples for requested word

  `iex> get_examples("verbose", "SECRET_API_KEY", [:use_canonical, limit: 5])`

  """
  @spec get_examples(String.t(), String.t(), examples_params()) ::
          {:error, String.t()} | {:ok, example()}
  def get_examples(word, api_key, params \\ []) do
    {fn_name, _} = __ENV__.function

    format_url(word, api_key)
    |> Formatter.Params.validate_and_fetch_query(params, @valid_params, fn_name)
  end
end
