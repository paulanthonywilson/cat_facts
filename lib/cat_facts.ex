defmodule CatFacts do
  @moduledoc """
  Gets facts about cats.
  """
  use CatFacts.CatFactsApi

  @spec fact ::
          {:ok, fact :: String.t()}
          | {:error, :nofact}
          | {:error, {:transport_error, any}}
          | {:error, {:server_error, code :: non_neg_integer(), body :: String.t()}}

  def fact do
    "fact"
    |> CatFactsApi.fetch_fun_feline_facts(CatFinch)
    |> handle_response()
  end

  defp handle_response({:error, reason}) do
    {:error, {:transport_error, reason}}
  end

  defp handle_response({:ok, %{status: 200, body: body}}) do
    case Jason.decode(body) do
      {:ok, term} ->
        get_data(term)
    end
  end

  defp handle_response({:ok, %{status: status, body: body}}) do
    {:error, {:server_error, status, body}}
  end

  defp get_data(%{"fact" => fact}) do
    {:ok, fact}
  end

  defp get_data(_), do: {:error, :nofact}
end
