class Request < ApplicationRecord
  
  belongs_to :course, :foreign_key => :course_id
  belongs_to :user, :foreign_key => :user_id
  
end
