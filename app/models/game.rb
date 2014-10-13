class Game < ActiveRecord::Base
  has_many :players
  has_many :missions
  belongs_to :king, class_name: "Player"

  validates_associated :players
  validates :players, length: { in: 5..11 }
  validates :missions, length: { is: 5 }

  def advance_king!
    self.king = players[(players.index(king) + 1) % players.length]
  end
end
