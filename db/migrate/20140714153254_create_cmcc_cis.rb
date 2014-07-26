class CreateCmccCis < ActiveRecord::Migration
  def change
    create_table :cmcc_cis do |t|
      t.text :name
      t.text :contact_info
      t.text :comment
      t.text :mac
      t.integer :company

      t.timestamps
    end
  end
end
