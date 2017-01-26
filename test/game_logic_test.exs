defmodule GameLogicTest do
  use ExUnit.Case, async: true

  test "move/3: a valid move should update the game state" do
    initial_state = GameLogic.init
    next_state = GameLogic.move(initial_state, 1, 1)

    assert initial_state.row_1 == [" ", " ", " "]
    assert next_state.row_1 == ["X", " ", " "]
    assert next_state.next_player == "O"
    assert ! next_state.game_over
  end

  test "move/3: should update :game_over to true for the winning move" do
    state = GameLogic.init("X",
                          ["X","X","X"],
                          ["X","O","X"],
                          [" ","X","O"])
    next_state = GameLogic.move(state, 3, 1)

    assert GameLogic.player_wins?(next_state, "X")
    assert next_state.game_over
  end

  test "player_wins?/2: should return false when game is not won for given player" do
    state = GameLogic.init("X",
                          ["O","X","X"],
                          ["X","O","O"],
                          ["O","X","X"])

    assert ! GameLogic.player_wins?(state, "O")
  end

  test "player_wins?/2: should return true when player X has completed a column" do
    state = GameLogic.init("O",
                          ["X","O","O"],
                          ["X","O","X"],
                          ["X","X","O"])

    assert GameLogic.player_wins?(state, "X")
  end

  test "player_wins?/2: should return true when player O has completed a column" do
    state = GameLogic.init("X",
                          ["O","X","X"],
                          ["O","X","O"],
                          ["O","O","X"])

    assert GameLogic.player_wins?(state, "O")
  end

  test "player_wins?/2: should return true when given player has completed a row" do
    state = GameLogic.init("X",
                          ["O","O","O"],
                          ["X","X","O"],
                          ["X","O","X"])

    assert GameLogic.player_wins?(state, "O")
  end
end
