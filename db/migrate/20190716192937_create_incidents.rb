class CreateIncidents < ActiveRecord::Migration
  def change
    create_table :incidents do |t|
      t.datetime :date_of
      t.string :location
      t.string :department
      t.text :description

      t.timestamps null: false
    end
  end
end
