class AddPublicToCourses < ActiveRecord::Migration[5.1]
  def change
    add_column :courses, :public, :boolean, default: false
  end
end
