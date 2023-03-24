# CatFacts

Uses the Cat Facts API to illustrate different approaches to creating a Mox style testing seam. See the accompanying blog post [here](https://furlough.merecomplexities.com/elixir/tdd/mocks/2023/03/24/elixir-mock-stub-fake-testing-seams-a-modest-proposal.html)

`CatFacts.CatFactsApi` is a behaviour and testing seam for extracting Cat Facts from [Cat Facts API](https://catfact.ninja). It is implemented by `CatFacts.RealCatFactsApi` and mocked by `MockCatFactsApi`.

Various versions can be seen with the following tags.

* [`initial_standard_moxing`](https://github.com/paulanthonywilson/cat_facts/tree/initial_standard_moxing) - the private function `CatFacts.CatFactsApi.cat_facts_api/0` reads application config to return the implementation. This is the normal way of doing things.
* [`accidental_behaviour_tag_deletion`](https://github.com/paulanthonywilson/cat_facts/tree/accidental_behaviour_tag_deletion) - a version in which I "accidentally" forgot to add `@behaviour CatFacts.CatFactsApi` to `CatFacts.RealCatFactsApi`. An ommission which will cause problems later. 
* [`rename_but_omit_implementation`](https://github.com/paulanthonywilson/cat_facts/tree/rename_but_omit_implementation) -  `CatFacts.CatFactsApi.get_cat_facts/0` has been renamed to `CatFacts.fetch_fun_feline_facts/0`. Thet tests are passing but I "forgot" to rename the function in `CatFacts.RealCatFactsApi`.
* [`alternate_implementation_injection`](https://github.com/paulanthonywilson/cat_facts/tree/alternate_implementation_injection) - inject the mock or real implementaton using `alias`. Still broken but compilation and `dialyzer` now gives warnings.
* [`final_working`](https://github.com/paulanthonywilson/cat_facts/tree/final_working) - all working fine again, with the new function name (and the `@behaviour` restored).
