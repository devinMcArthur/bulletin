class AddMoodleUsernameAndMoodlePasswordToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :moodle_username, :string
    add_column :users, :moodle_password, :string
  end
end
