class UniversityOffer < ApplicationRecord
  belongs_to :course
  has_many :offers

  validates :full_price, :max_payments, :enrollment_semester, presence: true
end
