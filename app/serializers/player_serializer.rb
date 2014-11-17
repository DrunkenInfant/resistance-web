class PlayerSerializer < ActiveModel::Serializer
  attributes :id, :team, :name
  has_one :game, embed: :id
  has_one :user, embed: :id

  def team
    if scope && (scope.id == object.user_id ||
                 object.game.find_player_by_user(scope).team == "spies")
      return object.team
    else
      return ""
    end
  end
end
