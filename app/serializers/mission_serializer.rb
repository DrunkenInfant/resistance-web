class MissionSerializer < ActiveModel::Serializer
  attributes :id, :nbr_participants, :nbr_fails_required, :index
  has_one :game, embed: :ids
  has_many :nominations, embed: :ids, include: true
  has_many :mission_results, embed: :ids, include: true
end

