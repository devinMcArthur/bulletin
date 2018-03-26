class Course < ApplicationRecord
  
  has_many :assignments, dependent: :destroy
  accepts_nested_attributes_for :assignments
  
  has_many :requests, dependent: :destroy

  has_and_belongs_to_many :users
  
  validates :title,       presence: true, length: { maximum: 150 }
  validates :code,        presence: true, length: { maximum: 10 }, numericality: { only_integer: true }
  validates :section,     presence: true, length: { maximum: 2 }, numericality: { only_integer: true }
  #validates :end_date,    inclusion: { in: (:start_date..Date.new(2020,1,1)) }
  
  def end_date_cannot_be_before_start_date
    if start_date < end_date
      errors.add(:end_date, "Must be after the Start Date")
    end
  end
  
end