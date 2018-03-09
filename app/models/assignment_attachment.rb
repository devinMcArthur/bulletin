class AssignmentAttachment < ApplicationRecord
  
  belongs_to :assignment, dependent: :destroy, inverse_of: :assignment_attachments
  
  has_attached_file :attachment
  do_not_validate_attachment_file_type :attachment

end
