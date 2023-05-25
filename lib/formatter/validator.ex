defmodule Formatter.Validator do
  @dictonaries [
    "all",
    "ahd-5",
    "century",
    "wiktionary",
    "webster",
    "wordnet"
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
end
