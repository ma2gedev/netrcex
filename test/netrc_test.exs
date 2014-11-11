defmodule NetrcTest do
  use ExUnit.Case

  test "read sample netrc" do
    netrc = Netrc.read("test/data/sample.netrc")
    assert is_map(netrc)
    assert Map.get(netrc, "m") == %{ "login" => "l", "password" => "p" }
  end

  test "read sample netrc reversed" do
    netrc = Netrc.read("test/data/sample_reverse.netrc")
    assert is_map(netrc)
    assert Map.get(netrc, "m") == %{ "login" => "l", "password" => "p" }
  end

  test "read sample netrc multi" do
    netrc = Netrc.read("test/data/multi.netrc")
    assert is_map(netrc)
    assert Map.get(netrc, "m") == %{ "login" => "l", "password" => "p" }
    assert Map.get(netrc, "m2") == %{ "login" => "l2", "password" => "p2" }
  end
end
