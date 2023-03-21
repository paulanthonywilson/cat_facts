defmodule CatFacts.CatFactsApi do
  @moduledoc """
  CatFacts api behaviour
  """

  @callback get_facts(path :: String.t(), finch_pool :: atom) ::
              {:ok, Finch.Response.t()} | {:error, Exception.t()}
end
