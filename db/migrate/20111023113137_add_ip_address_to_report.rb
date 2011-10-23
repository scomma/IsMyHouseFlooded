class AddIpAddressToReport < ActiveRecord::Migration
  def change
    add_column :reports, :ip_address, :string, null: true
  end
end
