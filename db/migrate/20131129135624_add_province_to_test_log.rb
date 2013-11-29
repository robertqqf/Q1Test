class AddProvinceToTestLog < ActiveRecord::Migration
  def change
    add_column :test_logs, :province, :integer
  end
end
