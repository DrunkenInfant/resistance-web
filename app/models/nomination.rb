class Nomination < ActiveRecord::Base
  has_and_belongs_to_many :players
  belongs_to :mission
  has_many :votes
  validates_associated :mission
  validate :one_vote_per_player, :validate_nbr_players

  def one_vote_per_player
    uniq_votes = votes.to_a.uniq { |v| v.player.id }
    if uniq_votes.length != votes.length and errors[:votes].empty?
      errors.add(:votes, "Only one vote per player")
      votes.last.errors.add(:player, "Only one vote per player")
    end
  end

  def validate_nbr_players
    if players.length != mission.nbr_participants
      errors.add(:players,
        "Incorrect number of nominated players, should be #{players}.")
    end
  end

  def vote_complete?
    votes.length == mission.game.players.length
  end

  def passed?
    vote_complete? and (votes.select { |v|
        v.pass
      }).length > mission.game.players.length / 2
  end
end
