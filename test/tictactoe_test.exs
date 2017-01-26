defmodule TicTacToeTest do
  use ExUnit.Case

  import Mock

  test "valid_input?/1: only valid combinations is accepted as moves" do
    assert ! TicTacToe.valid_input?("XYZ")
    assert ! TicTacToe.valid_input?("")
    assert ! TicTacToe.valid_input?(" ")

    assert TicTacToe.valid_input?("A3")
    assert TicTacToe.valid_input?("C2")
    assert TicTacToe.valid_input?("B1")

    assert ! TicTacToe.valid_input?("D2")
    assert ! TicTacToe.valid_input?("E4")
  end

  test "handle_move/2: valid move is passed to the Game module" do
    game = Game.start_game("X")
    move = "A1"
    dummy_state = GameLogic.init("X")
    {:ok, io} = StringIO.open("")
    with_mock Game, [move: fn(_game, _rnum, _cnum) -> dummy_state end] do
      TicTacToe.handle_move(move, game, io)

      assert called Game.move(game, 1, 1)
      assert StringIO.flush(io) == "\nEntered move: A1\n\nGame state:\n\n  A | B | C \n1   |   |  \n2   |   |  \n3   |   |  \n\nNext player: X"

      StringIO.close(io)
    end
  end

  test "handle_move/2: invalid move prints instructions and prints current state of game" do
    game = Game.start_game("X")
    move = "XYZ"
    dummy_state = GameLogic.init("X")
    {:ok, io} = StringIO.open("")
    with_mock GamePrinter, [print: fn(_state, io) -> nil end] do
      TicTacToe.handle_move(move, game, io)

      assert called GamePrinter.print(dummy_state, io)
      assert StringIO.flush(io) == "\nInvalid input. try entering the right one Like b1, c2, a1 etc."

      StringIO.close(io)
    end
  end
end
