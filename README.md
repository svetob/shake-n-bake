# shake-n-bake

Just save your code to recompile and test it.

Piece o cake!

## Install

Simply add it to your dependencies in mix.exs:

```elixir
def deps do
  [
    {:shake_n_bake, "~> 0.1.0", only: :dev}
  ]
end
```

## Configure

In your `config/config.exs` file, add:

```elixir
config :shake_n_bake,
  run_tests: true,
  test_cmd: "mix test",
  paths: ['./lib']
```

The following configurations are available:

- `run_tests` - Set to `true` to run your tests on recompile.
- `test_cmd` - Shell command to use for tests.
- `paths` - List of paths to check for modified files in

<!--
Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/shake_n_bake](https://hexdocs.pm/shake_n_bake).
-->
