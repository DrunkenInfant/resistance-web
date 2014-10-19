class MissionResultSerializer < ActiveModel::Serializer
  attributes :id
  has_one :player, embed: :ids
  has_one :mission, embed: :ids
end

