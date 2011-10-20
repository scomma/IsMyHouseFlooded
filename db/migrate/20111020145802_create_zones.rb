class CreateZones < ActiveRecord::Migration
  def change
    create_table :zones do |t|
      t.integer :reports_count,  null: false, default: 0
      t.integer :positive_count, null: false, default: 0
      t.integer :negative_count, null: false, default: 0
      t.integer :total_count,    null: false, default: 0

      t.timestamps
    end
  end
end
