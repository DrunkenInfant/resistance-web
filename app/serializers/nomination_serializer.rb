class NominationSerializer < ActiveModel::Serializer
  attributes :id
  has_one :mission, embed: :id
  has_many :players, embed: :ids
  has_many :votes, embed: :ids

  def include_votes?
    object.mission.game.players.length == object.votes.length
  end
end

