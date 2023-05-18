defmodule WordnikTest do
  use ExUnit.Case
  doctest Wordnik

  test "greets the world" do
    assert Wordnik.hello() == :world
  end
end
