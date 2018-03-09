class RemoveAssignmentAttachmentColumns < ActiveRecord::Migration[5.1]
  def change
    remove_column :assignment_attachments, :controller_id
    remove_column :assignment_attachments, :controller_name
  end
end
