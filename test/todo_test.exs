defmodule TodoTest do
  use ExUnit.Case
  doctest Todo

  test "greets the world" do
    assert Todo.hello() == :world
  end

  test "lsp works" do
    assert Todo.test_lsp() == :lsp
  end
end
