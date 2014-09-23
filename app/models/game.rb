class Game < ActiveRecord::Base
  has_many :players
  has_many :missions
  validates_associated :players
  validates :players, length: { in: 5..11 }
  validates :missions, length: { is: 5 }
end
