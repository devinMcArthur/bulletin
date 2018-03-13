class AddPublicToAssignment < ActiveRecord::Migration[5.1]
  def change
    add_column :assignments, :public, :boolean, default: false 
  end
end
