defmodule NetrcTest do
  use ExUnit.Case

  test "read sample netrc" do
    netrc = Netrc.read("test/data/sample.netrc")
    assert is_map(netrc)
    assert Map.get(netrc, "m") == %{ "login" => "l", "password" => "p" }
  end
end
