class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.string :name
      t.string :code
      t.text :url
      t.integer :created_by

      t.timestamps null: false
    end
  end
end
