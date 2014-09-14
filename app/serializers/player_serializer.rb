class PlayerSerializer < ActiveModel::Serializer
  attributes :id, :team
  has_one :game, embed: :id
  has_one :user, embed: :id

  def team
    if scope && scope.id == object.user_id
      return object.team
    else
      return ""
    end
  end
end
