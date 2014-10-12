class Mission < ActiveRecord::Base
  belongs_to :game
  has_many :nominations

  validates :nominations, length: { maximum: 5,
    too_many: "Only five nominations are allowed" }
  validate :only_one_active_nomination

  def only_one_active_nomination
    noms = nominations.to_a.select { |nom|
      nom.votes.length != game.players.length
    }
    if noms.length > 1 and errors[:nominations].empty?
      nominations.last.errors.add(:nomination,
                                  "Only one active nomination at a time")
    end
  end
end
