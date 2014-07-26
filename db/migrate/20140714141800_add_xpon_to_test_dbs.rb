class AddXponToTestDbs < ActiveRecord::Migration
  def change
    add_column :test_dbs, :cmcc_xpon, :integer
    add_column :test_dbs, :cmcc_status, :integer
    add_column :test_dbs, :union_xpon, :integer
    add_column :test_dbs, :union_status, :integer
    add_column :test_dbs, :tele_xpon, :integer
    add_column :test_dbs, :tele_status, :integer
  end
end
