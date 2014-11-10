defmodule Netrc do
  @doc """
  # read a `.netrc` file and return dict
  """
  def read(path \\ default_path) do
    File.read!(path)
    |> lex
    |> parse(%{})
  end

  defp default_path do
    System.get_env("HOME") |> Path.join(".netrc")
  end

  defp lex(data) do
    String.split(data, ~r{\s|\t|\n|\r}, trim: true)
  end

  defp parse([ "machine" | tokens], map) do
    [ name | tail ] = tokens
    map = Map.put(map, name, %{})
    parse(tail, map, name)
  end
  defp parse([_ | tokens], map) do
    parse(tokens, map)
  end
  defp parse([], map) do
    map
  end
  defp parse([ "login" | tokens ], map, machine) do
    [ login | tail ] = tokens
    creds = Map.get(map, machine)
    map = Map.put(map, machine, Map.put(creds, "login", login))
    parse(tail, map, machine)
  end
  defp parse([ "password" | tokens ], map, machine) do
    [ password | tail ] = tokens
    creds = Map.get(map, machine)
    map = Map.put(map, machine, Map.put(creds, "password", password))
    parse(tail, map, machine)
  end
  defp parse([ "machine" | tokens ], map, _machine) do
    parse([ "machine" | tokens ], map)
  end
  defp parse([], map, _machine) do
    map
  end
end
