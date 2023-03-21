defmodule CatFacts.RealCatFactsApi do
  @moduledoc """
  Actually calls the Cat Facts API
  """

  @cat_facts_base "https://catfact.ninja"

  def get_facts(path, finch_pool) do
    url = Path.join(@cat_facts_base, path)

    :get
    |> Finch.build(url)
    |> Finch.request(finch_pool)
  end
end
