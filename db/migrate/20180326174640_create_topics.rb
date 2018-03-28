class CreateTopics < ActiveRecord::Migration[5.1]
  def change
    create_table :topics do |t|
      t.string :title
      t.text :description
      t.datetime :release_date
      t.datetime :relevant_date
      t.integer :course_id
      t.boolean :public, default: false

      t.timestamps
    end
  end
end
