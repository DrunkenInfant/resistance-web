class Nomination < ActiveRecord::Base
  has_and_belongs_to_many :players
  belongs_to :mission
  has_many :votes
  validates_associated :mission
  validate :one_vote_per_player

  def one_vote_per_player
    uniq_votes = votes.to_a.uniq { |v| v.player.id }
    if uniq_votes.length != votes.length and errors[:votes].empty?
      errors.add(:votes, "Only one vote per player")
    end
  end
end
