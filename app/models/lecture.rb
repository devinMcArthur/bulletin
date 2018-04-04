class Lecture < ApplicationRecord
  belongs_to :course
  
  validates_presence_of :start
  validates_presence_of :end
end
