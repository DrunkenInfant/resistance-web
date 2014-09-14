class Game < ActiveRecord::Base
  has_many :players
  validates_associated :players
  validates :players, length: { in: 5..11 }
end
