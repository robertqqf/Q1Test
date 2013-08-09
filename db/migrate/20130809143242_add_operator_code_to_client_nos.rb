class AddOperatorCodeToClientNos < ActiveRecord::Migration
  def change
    add_column :client_nos, :operator_code, :integer
  end
end
