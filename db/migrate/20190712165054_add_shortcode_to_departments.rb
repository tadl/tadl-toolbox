class AddShortcodeToDepartments < ActiveRecord::Migration
  def change
    add_column :departments, :short_code, :string
  end
end
