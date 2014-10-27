class MissionResultSerializer < ActiveModel::Serializer
  attributes :id, :success
  has_one :mission, embed: :ids
end

