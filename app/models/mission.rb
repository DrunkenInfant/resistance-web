class Mission < ActiveRecord::Base
  belongs_to :game
  has_many :nominations
  has_many :mission_results

  validates :nominations, length: { maximum: 5,
    too_many: "Only five nominations are allowed" }
  validate :only_one_active_nomination
  validate :one_mission_result_per_player

  def only_one_active_nomination
    noms = nominations.to_a.select { |nom|
      nom.votes.length != game.players.length
    }
    if noms.length > 1 and errors[:nominations].empty?
      nominations.last.errors.add(:nomination,
                                  "Only one active nomination at a time")
    end
  end

  def one_mission_result_per_player
    uniq_mrs = mission_results.to_a.uniq { |mr| mr.player.id }
    if uniq_mrs.length != mission_results.length and errors[:mission_results].empty?
      errors.add(:mission_results, "Only one mission result per player")
    end
  end

  def passed_nomination
    noms = nominations.select do |n|
      n.passed?
    end
    return noms.first
  end
end
