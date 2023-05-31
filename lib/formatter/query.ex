defmodule Wordnik.Formatter.Query do
  @moduledoc false

  import Wordnik.Formatter.Params, only: [format_params: 2, standardize_params: 1]
  import Wordnik.Formatter.Validator, only: [validate_params: 3]

  defp handle_rate_limit_error({:ok, %{"message" => "API rate limit exceeded"}}) do
    {:error, "API rate limit exceeded"}
  end

  defp handle_rate_limit_error({:ok, resp}) do
    {:ok, resp}
  end

  defp format_response(response) do
    {:ok, Jason.decode!(response.body)}
  end

  # fetch formatted query and decode if success
  defp fetch_query({:ok, fmt_params}, url) do
    url
    |> format_params(fmt_params)
    |> HTTPoison.get!([], follow_redirect: true)
    |> format_response
    |> handle_rate_limit_error
  end

  # return error tuple if invalid parameter provided
  defp fetch_query({:error, msg}, _url) do
    {:error, msg}
  end

  # validate, format, and run query
  def validate_and_fetch_query(url, params, valid_params, fn_name) do
    api_key = System.get_env("WORDNIK_API_KEY")

    if api_key == nil do
      {:error, "'WORDNIK_API_KEY' could not be loaded from environment"}
    else
      params
      |> standardize_params
      |> validate_params(valid_params, fn_name)
      |> fetch_query(url <> "?api_key=#{api_key}")
    end
  end
end
