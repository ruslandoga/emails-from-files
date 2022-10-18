defmodule ETest do
  use ExUnit.Case
  doctest E

  test "greets the world" do
    assert E.hello() == :world
  end
end
