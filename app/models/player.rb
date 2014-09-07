class Player < ActiveRecord::Base

  belongs_to :user
  belongs_to :game

  validates :user, presence: true
  validates :game, presence: true
  validates :team, presence: true, inclusion: { in: %w(resistance spies) }

end
