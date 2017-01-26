defmodule GamePrinterTest do
  use ExUnit.Case, async: true

  test "print/2: should print a visual of the current game state" do
    game = Game.start_game("X")
    Game.move(game, 1, 1)
    Game.move(game, 2, 2)
    Game.move(game, 3, 3)
    new_state = Agent.get(game, fn state -> state end)
    {:ok, io}  = StringIO.open("")
    GamePrinter.print(new_state, io)

    assert StringIO.flush(io) == "\nGame state:\n\n  A | B | C \n1 X |   |  \n2   | O |  \n3   |   | X\n\nNext player: O"

    StringIO.close(io)
  end
end
