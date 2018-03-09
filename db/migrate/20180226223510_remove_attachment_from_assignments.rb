class RemoveAttachmentFromAssignments < ActiveRecord::Migration[5.1]
  def change
    remove_attachment :assignments, :attachment
  end
end
