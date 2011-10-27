class AddIndexToReport < ActiveRecord::Migration
  def change
    add_index :reports, [:zone_id, :created_at]
  end
end
