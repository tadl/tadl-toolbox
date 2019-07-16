class CreatePatrons < ActiveRecord::Migration
  def change
    create_table :patrons do |t|
      t.string :first_name
      t.string :last_name
      t.string :middle_name
      t.string :gender
      t.integer :age
      t.boolean :no_name
      t.string :card_number
      t.string :address
      t.string :city
      t.string :state
      t.integer :zip

      t.timestamps null: false
    end
  end
end
