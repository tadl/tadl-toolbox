class CreateCovers < ActiveRecord::Migration
  def change
    create_table :covers do |t|
      t.integer :record_id
      t.string :source
      t.integer :admin_id
      t.string :status

      t.timestamps null: false
    end
  end
end
