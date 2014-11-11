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

  test "default" do
    netrc = Netrc.read("test/data/default.netrc")
    assert is_map(netrc)
    assert Map.get(netrc, "default") == %{ "login" => "l", "password" => "p" }
  end

  test "multi with default" do
    netrc = Netrc.read("test/data/multi_with_default.netrc")
    assert is_map(netrc)
    assert Map.get(netrc, "m") == %{ "login" => "l", "password" => "p" }
    assert Map.get(netrc, "m2") == %{ "login" => "l2", "password" => "p2" }
    assert Map.get(netrc, "default") == %{ "login" => "dl", "password" => "dp" }
  end
end
