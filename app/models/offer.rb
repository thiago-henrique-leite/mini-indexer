class Offer < ApplicationRecord
  belongs_to :university_offer

  validates :discount_percentage, presence: true
end
