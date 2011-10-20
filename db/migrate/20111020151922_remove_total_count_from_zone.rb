class RemoveTotalCountFromZone < ActiveRecord::Migration
  def up
    remove_column :zones, :total_count
  end

  def down
    add_column :zones, :total_count, :integer, null: false, default: 0
  end
end
