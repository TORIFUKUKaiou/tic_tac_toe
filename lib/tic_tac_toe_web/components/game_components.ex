defmodule TicTacToeWeb.GameComponents do
  use Phoenix.Component

  attr :status, :string, required: true
  attr :squares, :list, required: true

  def board(assigns) do
    ~H"""
    <div>
      <div class="status"><%= @status %></div>
      <div class="board-row">
        <.square :for={index <- 0..2} index={index} content={Enum.at(@squares, index)} />
      </div>
      <div class="board-row">
        <.square :for={index <- 3..5} index={index} content={Enum.at(@squares, index)} />
      </div>
      <div class="board-row">
        <.square :for={index <- 6..8} index={index} content={Enum.at(@squares, index)} />
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
