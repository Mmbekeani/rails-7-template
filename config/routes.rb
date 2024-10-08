Rails.application.routes.draw do

  # This is a blank app! Pick your first screen, build out the RCAV, and go from there. E.g.:

  # get "/your_first_screen" => "pages#first"
  
end

Rails.application.routes.draw do
  root 'game#index'
  post 'play', to: 'game#play'
  get 'result', to: 'game#result'
end

class GameController < ApplicationController
  def index
  end

  def play
    @player_move = params[:move]
    @computer_move = ["rock", "paper", "scissors"].sample

    @result = if @player_move == @computer_move
                "It's a tie!"
              elsif win?(@player_move, @computer_move)
                "You win!"
              else
                "You lose!"
              end

    redirect_to result_path(player_move: @player_move, computer_move: @computer_move, result: @result)
  end

  def result
    @player_move = params[:player_move]
    @computer_move = params[:computer_move]
    @result = params[:result]
  end

  private

  def win?(player, computer)
    (player == "rock" && computer == "scissors") ||
      (player == "paper" && computer == "rock") ||
      (player == "scissors" && computer == "paper")
  end
end

<h1>Rock-Paper-Scissors</h1>
<p>Choose your move:</p>

<%= form_with url: play_path, method: :post do %>
  <%= radio_button_tag :move, 'rock' %>
  <%= label_tag :move_rock, 'Rock' %><br>

  <%= radio_button_tag :move, 'paper' %>
  <%= label_tag :move_paper, 'Paper' %><br>

  <%= radio_button_tag :move, 'scissors' %>
  <%= label_tag :move_scissors, 'Scissors' %><br>

  <%= submit_tag 'Play!' %>
<% end %>
<h1>Result</h1>
<p>You chose: <%= @player_move.capitalize %></p>
<p>Computer chose: <%= @computer_move.capitalize %></p>
<p><%= @result %></p>

<%= link_to 'Play again', root_path %>

