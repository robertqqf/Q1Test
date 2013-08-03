class AddPasswordToUser < ActiveRecord::Migration
  def change
    add_column :users, :password, :string
    add_column :users, :expire_date, :date
  end
end
