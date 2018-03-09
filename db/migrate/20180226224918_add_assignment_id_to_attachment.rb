class AddAssignmentIdToAttachment < ActiveRecord::Migration[5.1]
  def change
    add_column :attachments, :assignment_id, :integer
  end
end
