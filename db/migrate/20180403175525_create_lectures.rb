class CreateLectures < ActiveRecord::Migration[5.1]
  def change
    create_table :lectures do |t|
      t.datetime :start
      t.datetime :end
      t.integer :course_id
      t.integer :repeating_cycle, default: 0

      t.timestamps
    end
  end
end
