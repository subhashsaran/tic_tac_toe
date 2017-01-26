defmodule Game do
  @moduledoc """
  handle the game's state with Agents.
  """

  @doc """
  Start a new game.
  """
  def start_game(first_player) do
    initial_state = GameLogic.init(first_player)
    start_link(initial_state)
  end

  defp start_link(initial_state) do
    {:ok, pid} = Agent.start_link(fn -> initial_state end)
    pid
  end

  @doc """
  Executes move for next player.
  """
  def move(game, row_num, column_num) do
    state = game_state(game)
    next_state = GameLogic.move(state, row_num, column_num)
    Agent.update(game, fn _state -> next_state end)
    next_state
  end

  @doc """
  Returns the current state from Game Agent.
  """
  def game_state(game) do
    Agent.get(game, fn state -> state end)
  end
end
