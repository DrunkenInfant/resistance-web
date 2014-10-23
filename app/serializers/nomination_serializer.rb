class NominationSerializer < ActiveModel::Serializer
  attributes :id
  has_one :mission, embed: :id
  has_many :players, embed: :ids
  has_many :votes, embed: :ids, include: true
end

