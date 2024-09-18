defmodule TicTacToeWeb.TicTacToeLive.Index do
  use TicTacToeWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    history = [List.duplicate(nil, 9)]
    squares = Enum.at(history, 0)

    {:ok,
     socket
     |> assign(
       history: history,
       squares: squares,
       current_move: 0,
       winner: nil,
       status: status(nil, 0)
     )}
  end

  @impl true
  def handle_event("square_click", %{"ref" => index}, socket) do
    index = String.to_integer(index)
    square_click(socket, index, Enum.at(socket.assigns.squares, index))
  end

  @impl true
  def handle_event("move", %{"ref" => move}, socket) do
    move = String.to_integer(move)
    squares = Enum.at(socket.assigns.history, move)
    winner = TicTacToe.TicTacToes.calculate_winner(squares)

    {:noreply,
     assign(socket,
       squares: squares,
       current_move: move,
       winner: winner,
       status:
         status(
           winner,
           move
         )
     )}
  end

  defp square_click(socket, _index, value_of_index) when value_of_index != nil,
    do: {:noreply, socket}

  defp square_click(socket, _index, _value_of_index) when socket.assigns.winner != nil,
    do: {:noreply, socket}

  defp square_click(socket, index, _value_of_index) do
    current_move = socket.assigns.current_move

    next_squares = List.replace_at(socket.assigns.squares, index, mark(current_move))

    next_current_move = current_move + 1
    next_history = Enum.slice(socket.assigns.history, 0, next_current_move) ++ [next_squares]
    new_winner = TicTacToe.TicTacToes.calculate_winner(next_squares)
    status = status(new_winner, next_current_move)

    {:noreply,
     assign(socket,
       history: next_history,
       squares: next_squares,
       current_move: next_current_move,
       winner: new_winner,
       status: status
     )}
  end

  defp mark(current_move) when rem(current_move, 2) == 0, do: "X"
  defp mark(_current_move), do: "O"

  defp status(winner, _current_move) when winner != nil, do: "Winner: " <> winner
  defp status(_winner, current_move), do: "Next Player: " <> mark(current_move)
end
