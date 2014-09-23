class MissionSerializer < ActiveModel::Serializer
  attributes :id, :nbr_participants, :nbr_fails_required
  has_one :game, embed: :ids
end

