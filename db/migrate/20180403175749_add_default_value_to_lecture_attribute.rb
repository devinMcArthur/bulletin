class AddDefaultValueToLectureAttribute < ActiveRecord::Migration[5.1]
  def change
    change_column :lectures, :repeating_cycle, :integer, default: 0
  end
end
