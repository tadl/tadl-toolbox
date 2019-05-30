class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.integer :stat_id
      t.integer :value
      t.integer :last_edit_by
      t.integer :department_id

      t.timestamps null: false
    end
  end
end
