class Course < ApplicationRecord
  
  belongs_to :user, :foreign_key => :admin_id
  #has_many :assignments, dependent: :destroy
  
  validates :title,       presence: true, length: { maximum: 150 }
  validates :code,        presence: true, length: { maximum: 15 }, numericality: { only_integer: true }
  validates :section,     presence: true, length: { maximum: 2 }, numericality: { only_integer: true }
  validates :description, presence: true
  
end