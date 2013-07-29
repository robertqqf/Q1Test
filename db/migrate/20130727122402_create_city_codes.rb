class CreateCityCodes < ActiveRecord::Migration
  def change
    create_table :city_codes do |t|
      t.string :city_name
      t.integer :city_code

      t.timestamps
    end
  end
end
