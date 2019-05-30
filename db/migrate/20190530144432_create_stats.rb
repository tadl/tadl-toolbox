class CreateStats < ActiveRecord::Migration
  def change
    create_table :stats do |t|
      t.string :code
      t.string :name
      t.string :group_name
      t.date :start_date
      t.date :end_date

      t.timestamps null: false
    end
  end
end
