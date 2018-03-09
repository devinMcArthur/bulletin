class AddAttachmentToAssignment < ActiveRecord::Migration[5.1]
  def change
    add_attachment :assignments, :attachment
  end
end
