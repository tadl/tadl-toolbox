class ChangeLastEditByToString < ActiveRecord::Migration
  def change
    change_column :reports, :last_edit_by, :string
  end
end
