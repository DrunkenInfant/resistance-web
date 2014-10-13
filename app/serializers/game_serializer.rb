class GameSerializer < ActiveModel::Serializer
  attributes :id, :king_id
  has_many :players, embed: :ids, include: true
  has_many :missions, embed: :ids, include: true
end
