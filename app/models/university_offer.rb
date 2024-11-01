class UniversityOffer < ApplicationRecord
  belongs_to :course
  has_many :offers

  validates :full_price, :max_payments, :enrollment_semester, presence: true
  validates :full_price, :max_payments, numericality: { greater_than: 0 }
  validates :enrollment_semester, format: { with: /\A\d{4}\.\d\z/ }
end
