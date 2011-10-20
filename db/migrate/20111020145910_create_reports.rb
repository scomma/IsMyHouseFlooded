class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.references :zone, null: false
      t.boolean :flooded, null: true
      t.string :author,   null: true
      t.string :comment,  null: true

      t.timestamps
    end
    add_index :reports, :zone_id
  end
end
