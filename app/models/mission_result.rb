class MissionResult < ActiveRecord::Base
  belongs_to :player
  belongs_to :mission
  validate :results_from_correct_players
  validates_associated :mission

  def results_from_correct_players
    if mission.passed_nomination == nil
        errors.add(:mission, "No nomination has passed")
    else
      unless mission.passed_nomination.players.include? player
        errors.add(:player, "Only players in the mission may add result")
      end
    end
  end

end
