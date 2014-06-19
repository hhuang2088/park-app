class Spot < ActiveRecord::Base
  validates :longitude, presence: true
  validates :latitude, presence: true
  belongs_to :user 
end
