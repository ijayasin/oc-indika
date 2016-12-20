class Map < ApplicationRecord
  validates_presence_of :lat1, :lng1, :lat2, :lng2

  acts_as_paranoid column: :destroyed_at

  # https://www.mapbox.com/mapbox-gl-js/api/#LngLatBoundsLike
  def bounds
    [[lng1, lat1], [lng2, lat2]]
  end
end
