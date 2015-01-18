class GameSerializer < ActiveModel::Serializer
  attributes :id, :king_id, :created_at
  has_many :players, embed: :ids, include: true
  has_many :missions, embed: :ids
end
