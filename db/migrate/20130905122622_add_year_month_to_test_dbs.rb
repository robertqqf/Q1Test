class AddYearMonthToTestDbs < ActiveRecord::Migration
  def change
    add_column :test_dbs, :year, :integer
    add_column :test_dbs, :month, :integer
  end
end
