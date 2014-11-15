defmodule NetrcTest do
  use ExUnit.Case

  setup do
    Path.wildcard("test/data/*.netrc")
    |> Enum.each(&File.chmod(&1, 0o100600))
    File.chmod("test/data/permissive.netrc", 0o100644)
    :ok
  end

  test "read sample netrc" do
    netrc = Netrc.read("test/data/sample.netrc")
    assert Map.get(netrc, "m") == %{ "login" => "l", "password" => "p" }
  end

  test "read sample netrc reversed" do
    netrc = Netrc.read("test/data/sample_reverse.netrc")
    assert Map.get(netrc, "m") == %{ "login" => "l", "password" => "p" }
  end

  test "read sample netrc multi" do
    netrc = Netrc.read("test/data/multi.netrc")
    assert Map.get(netrc, "m") == %{ "login" => "l", "password" => "p" }
    assert Map.get(netrc, "m2") == %{ "login" => "l2", "password" => "p2" }
  end

  test "default" do
    netrc = Netrc.read("test/data/default.netrc")
    assert Map.get(netrc, "default") == %{ "login" => "l", "password" => "p" }
  end

  test "multi with default" do
    netrc = Netrc.read("test/data/multi_with_default.netrc")
    assert Map.get(netrc, "m") == %{ "login" => "l", "password" => "p" }
    assert Map.get(netrc, "m2") == %{ "login" => "l2", "password" => "p2" }
    assert Map.get(netrc, "default") == %{ "login" => "dl", "password" => "dp" }
  end

  test "raise exception when read a permissive file" do
    assert_raise Netrc.Error, fn ->
      Netrc.read("test/data/permissive.netrc")
    end
  end
end
