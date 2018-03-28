class CreateTopicAttachments < ActiveRecord::Migration[5.1]
  def change
    create_table :topic_attachments do |t|
      t.integer :topic_id
      t.attachment :attachment

      t.timestamps
    end
  end
end
