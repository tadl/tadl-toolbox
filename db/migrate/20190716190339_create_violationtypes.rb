class CreateViolationtypes < ActiveRecord::Migration
  def change
    create_table :violationtypes do |t|
      t.string :descritption
      t.string :first_offence
      t.string :second_offence
      t.string :subsiquent_offence

      t.timestamps null: false
    end
  end
end
