defmodule Netrc do
  import Bitwise

  @doc """
  # read a `.netrc` file and return dict

  iex> Netrc.read("test/data/sample.netrc")
  %{"m" => %{"login" => "l", "password" => "p"}}
  """
  def read(path \\ default_path) do
    {:ok, file_stat} = File.stat(path)
    unless (file_stat.mode &&& 0o777) == 0o600 do
      raise Netrc.Error, message: "'#{path}' permission should be 0600"
    end
    File.read!(path)
    |> lex
    |> parse(%{})
  end

  defp default_path do
    filename = case :os.type() do
      {:win32, _} -> "_netrc"
      _             -> ".netrc"
    end
    System.user_home |> Path.join(filename)
  end

  defp lex(data) do
    String.split(data, ~r{\r?\n})
    |> Enum.map(fn(line) ->
      String.split(line, "#") |> Enum.at(0)
    end)
    |> Enum.join(" ")
    |> String.split(~r{\s|\t|\n|\r}, trim: true)
  end

  defp parse([ "machine" | tokens], map) do
    [ name | tail ] = tokens
    map = Map.put(map, name, %{})
    parse(tail, map, name)
  end
  defp parse([ "default" | tokens], map) do
    map = Map.put(map, "default", %{})
    parse(tokens, map, "default")
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
  defp parse([ "default" | tokens ], map, _machine) do
    parse([ "default" | tokens ], map)
  end
  defp parse([], map, _machine) do
    map
  end

  defmodule Error do
    defexception message: "error"
  end
end

