defmodule CatFacts.CatFactsApi do
  @moduledoc """
  CatFacts api behaviour
  """

  @callback fetch_fun_feline_facts(path :: String.t(), finch_pool :: atom) ::
              {:ok, Finch.Response.t()} | {:error, Exception.t()}

  @implementation if Mix.env() == :test, do: MockCatFactsApi, else: CatFacts.RealCatFactsApi
  defmacro __using__(_) do
    quote do
      alias unquote(@implementation), as: CatFactsApi
    end
  end
end
