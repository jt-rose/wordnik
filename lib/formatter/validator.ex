defmodule Wordnik.Formatter.Validator do
  @moduledoc false

  @dictonaries [
    "all" | Wordnik.Helpers.get_dictionaries()
  ]

  defp valid_source_dict?(dict), do: dict in @dictonaries

  def has_valid_sources?(source) when source in @dictonaries, do: true

  def has_valid_sources?(sources) do
    if String.contains?(sources, "all") do
      false
    else
      sources
      |> String.split(",")
      |> Enum.filter(fn str -> str != "" end)
      |> Enum.all?(&valid_source_dict?/1)
    end
  end

  defp extract_param_name({name, _}), do: name

  # validate params against accepted list of parameters
  def validate_params(params, valid_list, fn_name) do
    invalid_param =
      params
      |> Enum.map(&extract_param_name/1)
      |> Enum.find(fn name -> name not in valid_list end)

    if invalid_param == nil do
      {:ok, params}
    else
      {:error, "'#{invalid_param}' not a valid parameter for the '#{fn_name}' function"}
    end
  end
end
