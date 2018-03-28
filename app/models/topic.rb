class Topic < ApplicationRecord
  
  belongs_to :course, :foreign_key => :course_id
  
  validates :title, presence: true, length: { maximum: 100 }
  
  has_many :topic_attachments, dependent: :destroy, inverse_of: :topic
  accepts_nested_attributes_for :topic_attachments, allow_destroy: true
  
end
