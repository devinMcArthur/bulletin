class CreateAttachments < ActiveRecord::Migration[5.1]
  def change
    create_table :attachments do |t|
      t.string :controller_name
      t.integer :controller_id
      t.attachment :attachment

      t.timestamps
    end
  end
end
