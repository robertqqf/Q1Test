class AddProvinceToTestDb < ActiveRecord::Migration
  def change
    add_column :test_dbs, :province, :integer
  end
end
