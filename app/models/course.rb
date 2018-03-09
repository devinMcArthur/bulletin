class Course < ApplicationRecord
  
  has_many :assignments, dependent: :destroy
  accepts_nested_attributes_for :assignments
  
  has_many :requests, dependent: :destroy

  has_and_belongs_to_many :users
  
  validates :title,       presence: true, length: { maximum: 150 }
  validates :code,        presence: true, length: { maximum: 10 }
  validates :section,     presence: true, length: { maximum: 2 }, numericality: { only_integer: true }
  validates :description, presence: true
  
end