class VoteSerializer < ActiveModel::Serializer
  attributes :id, :pass
  has_one :player, embed: :id, include: false
  has_one :nomination, embed: :id, include: false
end
