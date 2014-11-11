# Netrc - Reads netrc files implemented in Elixir

## Usage

### Read netrc files

Read the user's default netrc file:

```
iex> Netrc.read
%{"api.github.com" => %{"login" => "username", "password" => "pass"}}
```

Read the specific file path:

```
iex> Netrc.read("test/data/sample.netrc")
%{"m" => %{"login" => "l", "password" => "p"}}
```

## License

Copyright © 2014 Takayuki Matsubara, released under the MIT license.

