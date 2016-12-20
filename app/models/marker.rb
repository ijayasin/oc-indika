class Marker < ApplicationRecord
  validates_presence_of :lng, :lat

  acts_as_paranoid column: :destroyed_at

  belongs_to :user
  belongs_to :map

  def coordinates
    [lng, lat]
  end
end
