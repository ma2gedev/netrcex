# Netrc - Reads netrc files implemented in Elixir

[![hex.pm version](https://img.shields.io/hexpm/v/netrc.svg)](https://hex.pm/packages/netrc) [![hex.pm downloads](https://img.shields.io/hexpm/dt/netrc.svg)](https://hex.pm/packages/netrc) [![Build Status](https://travis-ci.org/ma2gedev/netrcex.svg?branch=master)](https://travis-ci.org/ma2gedev/netrcex)

## Installation

Add `:netrc` library to your project's dependencies in `mix.exs`:

```elixir
defp deps do
  [
    {:netrc, "~> 0.0.1"}
  ]
end
```

And fetch:

```
$ mix deps.get
```

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

