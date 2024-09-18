defmodule TicTacToeWeb.GameComponents do
  use Phoenix.Component

  attr :status, :string, required: true
  attr :squares, :list, required: true

  def board(assigns) do
    ~H"""
    <div>
      <div class="status"><%= @status %></div>
      <div class="board-row">
        <.square index={0} content={Enum.at(@squares, 0)} />
        <.square index={1} content={Enum.at(@squares, 1)} />
        <.square index={2} content={Enum.at(@squares, 2)} />
      </div>
      <div class="board-row">
        <.square index={3} content={Enum.at(@squares, 3)} />
        <.square index={4} content={Enum.at(@squares, 4)} />
        <.square index={5} content={Enum.at(@squares, 5)} />
      </div>
      <div class="board-row">
        <.square index={6} content={Enum.at(@squares, 6)} />
        <.square index={7} content={Enum.at(@squares, 7)} />
        <.square index={8} content={Enum.at(@squares, 8)} />
      </div>
    </div>
    """
  end

  attr :index, :integer, required: true
  attr :content, :string, default: nil

  def square(assigns) do
    ~H"""
    <button class="square" phx-click="square_click" phx-value-ref={@index}><%= @content %></button>
    """
  end

  slot :inner_block, required: true
  attr :entries, :list, required: true

  def ordered_list(assigns) do
    ~H"""
    <ol>
      <%= for index <- @entries do %>
        <li key={index}><%= render_slot(@inner_block, index) %></li>
      <% end %>
    </ol>
    """
  end
end
