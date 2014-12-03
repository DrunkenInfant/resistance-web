class MissionResultSerializer < ActiveModel::Serializer
  attributes :id, :success
  has_one :mission, embed: :ids
  has_one :player, embed: :ids

  def include_player?
    scope && scope.id == object.player.user_id
  end
end

