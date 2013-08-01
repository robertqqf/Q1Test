class AddCityCodeToUser < ActiveRecord::Migration
  def change
    add_column :users, :city_code_id, :integer
  end
end
