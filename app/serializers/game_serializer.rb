class GameSerializer < ActiveModel::Serializer
  attributes :id
  has_many :players, embed: :ids, include: true
end
