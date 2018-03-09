class Assignment < ApplicationRecord
  
  belongs_to :course, :foreign_key => :course_id
  
  validates :title, presence: true, length: { maximum: 100 }
  
  has_many :assignment_attachments, dependent: :destroy, inverse_of: :assignment
  accepts_nested_attributes_for :assignment_attachments, allow_destroy: true
  
end
