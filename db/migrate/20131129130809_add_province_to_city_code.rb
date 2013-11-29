class AddProvinceToCityCode < ActiveRecord::Migration
  def change
    add_column :city_codes, :province, :integer
  end
end
