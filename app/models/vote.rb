class Vote < ActiveRecord::Base
  belongs_to :player
  belongs_to :nomination
  validates_associated :nomination
end
