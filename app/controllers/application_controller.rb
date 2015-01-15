class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  serialization_scope :current_user

  def push_game_update(game)
      game.players.each do |player|
        WebsocketRails.users[player.user.id].send_message(:update,
          GameSerializer.new(game, scope: player.user),
          namespace: :game)
      end
  end

end
