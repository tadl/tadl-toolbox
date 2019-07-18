class AddPatronpicsToPatron < ActiveRecord::Migration
  def change
    add_column :patrons, :patronpic, :json
  end
end
