Tic Tac Toe with Elixir

# Build

run following after cd into the directory.

``` bash
mix deps.get
mix escript.build
```

Tests can be run by `mix test`.

The target ```escript.build``` produces an executable escript.And can be run on any machine that has Erlang installed.

# Start

These inputs are understood: 'exit', 'new' and moves such as 'a1', 'b2' etc. Inputs are not case sensitive.

Run below for start playing the game.

``` bash
./tictactoe
```
