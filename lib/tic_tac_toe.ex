defmodule TicTacToe do
  @moduledoc """
  Defines the whole interface for the game.
  """

  @doc """
  Start a Game and enters the process loop.
  """
  def main(_args) do
    game = Game.start_game("X")
    GamePrinter.print(Game.game_state(game))
    process(game)
  end

  defp process(game) do
    IO.puts "\n"
    cmd = IO.gets "Command: "
    input = String.upcase(String.strip(cmd))
    case input do
      "NEW" -> new_game(game)
      "EXIT" -> terminate()
      move ->
        current_state = Game.game_state(game)
        if (current_state.game_over) do
          usage(current_state)
        else
          handle_move(move, game)
        end
        process(game)
    end
  end

  @doc """
  Passes a valid move on to the Game, blocks an invalid move and outputs a
  usage hint.
  """
  def handle_move(move, game, io_device \\ Process.group_leader()) do
    case valid_input?(move) do
      true ->
        IO.write(io_device, "\nEntered move: #{move}\n")
        next_state = Game.move(game, row_num(move), column_num(move))
        GamePrinter.print(next_state, io_device)
      _ ->
        current_state = Game.game_state(game)
        usage(current_state, io_device)
        GamePrinter.print(current_state, io_device)
    end
  end

  @doc """
  Validates incoming moves to make sure they are of the form 'C1', 'B2', etc.
  """
  def valid_input?(move) do
    Regex.match?(~r/^[A-C][1-3]$/, move)
  end

  defp row_num(input) do
    String.to_integer(String.at(input, 1))
  end

  defp column_num(input) do
    case String.at(input, 0) do
      "A" -> 1
      "B" -> 2
      "C" -> 3
    end
  end

  defp new_game(game) do
    :ok = Agent.stop(game)
    next_game = Game.start_game("X")
    IO.puts "\nNew game\n"
    GamePrinter.print(Game.game_state(next_game))
    process(next_game)
  end

  defp terminate() do
    IO.puts "\nGood Bye\n"
    System.halt(0)
  end

  defp usage(state, io_device \\ Process.group_leader()) do
    case state.game_over do
      true ->
        IO.write(io_device, "\nGame over. Please enter either 'new' or 'exit'")
      _ ->
        IO.write(io_device, "\nInvalid input. try entering the right one Like b1, c2, a1 etc.")
    end
  end
end
