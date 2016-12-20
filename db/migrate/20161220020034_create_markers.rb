class CreateMarkers < ActiveRecord::Migration[5.0]
  def change
    create_table :markers do |t|
      t.belongs_to  :user,        null: false, foreign_key: true
      t.belongs_to  :map,         null: false, foreign_key: true
      t.float       :lng,         null: false
      t.float       :lat,         null: false
      t.string      :icon,        default: 'marker'
      t.string      :name
      t.string      :description
      t.integer     :residents

      t.timestamps
      t.datetime    :destroyed_at

      t.index [:user_id, :map_id]
    end
  end
end
