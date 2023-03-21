defmodule CatFactsTest do
  use ExUnit.Case

  import Mox

  setup :verify_on_exit!

  test "Can get a fact" do
    expect(MockCatFactsApi, :get_facts, fn "fact", CatFinch ->
      {:ok,
       %Finch.Response{
         body: "{\"fact\":\"Cats are really dogs in disguise.\",\"length\":33}",
         status: 200
       }}
    end)

    assert {:ok, "Cats are really dogs in disguise."} == CatFacts.fact()
  end

  test "Can handle a lack of facts" do
    expect(MockCatFactsApi, :get_facts, fn "fact", CatFinch ->
      {:ok,
       %Finch.Response{
         body: "{}",
         status: 200
       }}
    end)

    assert {:error, :nofact} == CatFacts.fact()
  end

  test "Gracefully handles server errors" do
    expect(MockCatFactsApi, :get_facts, fn "fact", CatFinch ->
      {:ok,
       %Finch.Response{
         body: "Hot tin roof!",
         status: 500
       }}
    end)

    assert {:error, {:server_error, 500, "Hot tin roof!"}} == CatFacts.fact()
  end

  test "Gracefully handles transport error" do
    expect(MockCatFactsApi, :get_facts, fn "fact", CatFinch ->
      {:error, %Mint.TransportError{reason: :nxdomain}}
    end)

    assert {:error, {:transport_error, %{reason: :nxdomain}}} = CatFacts.fact()
  end
end
