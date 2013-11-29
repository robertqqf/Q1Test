class AddProvinceToClientNo < ActiveRecord::Migration
  def change
    add_column :client_nos, :province, :integer
  end
end
