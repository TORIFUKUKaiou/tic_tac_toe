defmodule TicTacToe.TicTacToes do
  def calculate_winner(squares) do
    lines = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6]
    ]

    lines
    |> Enum.reduce_while(nil, fn [a, b, c], nil ->
      if Enum.at(squares, a) && Enum.at(squares, a) == Enum.at(squares, b) &&
           Enum.at(squares, a) == Enum.at(squares, c) do
        {:halt, Enum.at(squares, a)}
      else
        {:cont, nil}
      end
    end)
  end
end
