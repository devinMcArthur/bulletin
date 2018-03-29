class AddColumnsToAssignments < ActiveRecord::Migration[5.1]
  def change
    add_column :assignments, :importance, :string, default: "Standard"
  end
end
