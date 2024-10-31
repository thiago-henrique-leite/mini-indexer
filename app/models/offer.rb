class Offer < ApplicationRecord
  belongs_to :university_offers

  validates :discount_percentage, :enabled, presence: true
end
