class CreateTestDbs < ActiveRecord::Migration
  def change
    create_table :test_dbs do |t|
      t.integer :city_code
      t.integer :cs
      t.integer :count
      t.integer :status
      t.integer :user_id

      t.timestamps
    end
  end
end
