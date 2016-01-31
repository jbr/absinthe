defmodule Specification.TypeSystem.Types.ListsTest do
  use ExSpec, async: true
  @moduletag specification: true

  @graphql_spec "#sec-Lists"

  defmodule Schema do
    use Absinthe.Schema
    alias Absinthe.Type

    def query do
      %Type.Object{
        fields: fields(
          valid: [
            type: list_of(:integer),
            resolve: fn _, _ -> {:ok, [1,2,3]} end
          ],
          invalid: [
            type: list_of(:integer),
            resolve: fn _, _ -> {:ok, [1]} end
          ],
          takes_list: [
            type: :boolean,
            args: args(
              list: [type: list_of(:integer)]
            ),
            resolve: fn
            %{list: val} when is_list(val)
              -> {:ok, true}
            _ -> {:ok, false}
            end
          ]
        )
      }
    end

  end

  describe "if a list is returned" do
    @query "{ valid }"
    @tag :pending
    describe "coercion passes" do
      assert {:ok, %{data: %{"valid" => [1, 2, 3]}}} == Absinthe.run(@query, Schema)
    end
  end


  describe "if a non-list is returned" do
    @query "{ invalid }"
    @tag :pending
    describe "coercion fails" do
      assert {:ok, %{errors: _}} = Absinthe.run(@query, Schema)
    end
  end

  describe "if the value is passed as input to a list type is not a list" do
    @tag :pending
    it "should be coerced as though the input was a list of size one" do

    end
  end

end
