class Enrollment < ApplicationRecord
  belongs_to :student
  has_many :bills
  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :installments, presence: true, numericality: { greater_than: 1 }
  validates :due_day, presence: true, inclusion: { in: 1..31 }
end
