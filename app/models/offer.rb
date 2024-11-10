class Offer < ApplicationRecord
  belongs_to :university_offer
  has_one :course, through: :university_offer

  validates :discount_percentage, presence: true
  validates :discount_percentage, numericality: { greater_than: 0, less_than_or_equal_to: 100 }

  scope :enabled, -> { where(enabled: true) }
  scope :by_course_id, ->(course_id) { joins(:university_offer).where(university_offers: { course_id: course_id }) }
end
