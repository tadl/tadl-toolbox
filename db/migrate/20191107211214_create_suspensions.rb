class CreateSuspensions < ActiveRecord::Migration
  def change
    create_table :suspensions do |t|
      t.date :start_date
      t.date :end_date
      t.integer :patron_id

      t.timestamps null: false
    end
  end
end
