class AddPasswordToVolunteers < ActiveRecord::Migration
  def change
    add_column :volunteers, :password, :string
  end
end
