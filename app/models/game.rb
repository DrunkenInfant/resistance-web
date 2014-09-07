class Game < ActiveRecord::Base
  has_many :players
  validates_associated :players
  validates :players, length: { in: 5..11 }

  def as_json(options={})
    super(
      options.merge!({ root: true, include: :players}) { |key, newval, oldval|
        newval | oldval
      }
    )
  end
end
