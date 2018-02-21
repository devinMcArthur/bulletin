class Assignment < ApplicationRecord
  belongs_to :course, :foreign_key => :course_id
  
  validates :title, presence: true, length: { maximum: 100 }
  validates :description, presence: true
end
