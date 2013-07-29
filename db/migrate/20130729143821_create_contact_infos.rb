class CreateContactInfos < ActiveRecord::Migration
  def change
    create_table :contact_infos do |t|
      t.string :name
      t.string :contact_info
      t.string :comment
      t.string :mac
      t.integer :company, default: 0

      t.timestamps
    end
  end
end
