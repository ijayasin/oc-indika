require 'rails_helper'

describe Map, type: :model do

  describe '#bounds' do
    let(:map){ Map.new(name: 'Map1', lng1: 111.111, lat1: 11.11, lng2: 222.222, lat2: 22.22) }

    it 'returns an array of long-lat arrays' do
      expect(map.bounds).to eq [[111.111, 11.11], [222.222, 22.22]]
    end

    it 'can be rendered as JSON using to_json' do
      expect(map.bounds.to_json).to eq "[[111.111,11.11],[222.222,22.22]]"
    end
  end

  describe '#destroy' do
    it 'soft-deletes the record' do
      map = Map.create(name: 'Map1', lat1: 11, lng1: 111, lat2: 22, lng2: 222)
      expect(map).to_not be_new_record
      expect(map.destroyed_at).to be_nil

      # Soft-delete record
      map.destroy

      expect(map.reload.destroyed_at).to_not be_nil
      expect{ Map.find(map.id) }.to raise_exception ActiveRecord::RecordNotFound
      expect(Map.with_deleted.find(map.id)).to be_a(Map)
    end
  end

  describe 'validations' do
    it 'validates presence of required fields' do
      (map = Map.new).save
      expect(map).to be_new_record
      full_messages = map.errors.full_messages
      expect(full_messages).to include "Lat1 can't be blank"
      expect(full_messages).to include "Lng1 can't be blank"
      expect(full_messages).to include "Lat2 can't be blank"
      expect(full_messages).to include "Lng2 can't be blank"
    end
  end
end
