class CreateViolations < ActiveRecord::Migration
  def change
    create_table :violations do |t|
      t.date :date_issued
      t.integer :violationtype_id
      t.references :incident, index: true, foreign_key: true
      t.references :patron, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
