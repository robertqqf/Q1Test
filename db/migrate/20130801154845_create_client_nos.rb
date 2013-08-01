class CreateClientNos < ActiveRecord::Migration
  def change
    create_table :client_nos do |t|
      t.string :c_no
      t.integer :city_code_id
      t.integer :user_id

      t.timestamps
    end
  end
end
