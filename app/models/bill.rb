class Bill < ApplicationRecord
  belongs_to :enrollment
  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :due_date, presence: true
  validates :status, presence: true, inclusion: { in: %w(open pending paid) }

  before_validation :set_default_status, on: :create
  private

  def set_default_status
    self.status ||= 'open'
  end
end
