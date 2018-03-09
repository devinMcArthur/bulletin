class RenameAttachmentsToAssignmentAttachments < ActiveRecord::Migration[5.1]
  def change
    rename_table :attachments, :assignment_attachments
  end
end
