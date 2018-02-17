class CreateCourses < ActiveRecord::Migration[5.1]
  def change
    create_table :courses do |t|
      t.string :title
      t.string :code
      t.integer :section
      t.string :admin
      t.integer :admin_id
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end
  end
end
