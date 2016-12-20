require 'rails_helper'

RSpec.describe Marker, type: :model do
  describe '#coordinates' do
    let(:marker){ Marker.new(lng: 111.111, lat: 11.11) }

    it 'returns an array of long-lat arrays' do
      expect(marker.coordinates).to eq [111.111, 11.11]
    end

    it 'can be rendered as JSON using to_json' do
      expect(marker.coordinates.to_json).to eq "[111.111,11.11]"
    end
  end

  describe 'validations' do
    it 'validates presence of required fields' do
      (marker = Marker.new).save
      expect(marker).to be_new_record
      full_messages = marker.errors.full_messages
      expect(full_messages).to include "Lat can't be blank"
      expect(full_messages).to include "Lng can't be blank"
    end
  end
end
