class VoteSerializer < ActiveModel::Serializer
  attributes :id, :pass
  has_one :player, embed: :id, include: false
  has_one :nomination, embed: :id, include: false

  def include_pass?
    scope && scope.id == object.player.user_id ||
      object.nomination.vote_complete?
  end
end
