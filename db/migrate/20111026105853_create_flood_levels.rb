class CreateFloodLevels < ActiveRecord::Migration
  def change
    create_table :flood_levels do |t|
      t.references :zone,  null: false
      t.datetime   :at,    null: false
      t.integer    :level, null: true

      t.timestamps
    end
    add_index :flood_levels, :zone_id
    add_index :flood_levels, [:zone_id, :at], unique: true
  end
end
