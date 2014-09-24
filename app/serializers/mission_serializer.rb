class MissionSerializer < ActiveModel::Serializer
  attributes :id, :nbr_participants, :nbr_fails_required, :index
  has_one :game, embed: :ids
end

