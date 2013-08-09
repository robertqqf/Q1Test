class CreateTestLogs < ActiveRecord::Migration
  def change
    create_table :test_logs do |t|
      t.string :cno
      t.integer :city_code

      t.timestamps
    end
  end
end
