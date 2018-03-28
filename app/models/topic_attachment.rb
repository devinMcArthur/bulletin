class TopicAttachment < ApplicationRecord
  
  belongs_to :topic, inverse_of: :topic_attachments
  
  has_attached_file :attachment
  do_not_validate_attachment_file_type :attachment
  
end
