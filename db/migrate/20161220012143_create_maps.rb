class CreateMaps < ActiveRecord::Migration[5.0]
  def change
    create_table :maps do |t|
      t.belongs_to :user

      t.string :name
      t.string :description

      t.float :lat1
      t.float :lng1

      t.float :lat2
      t.float :lng2

      t.float :zoom

      t.datetime :destroyed_at

      t.timestamps
    end
  end
end
