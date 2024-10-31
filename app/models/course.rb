class Course < ApplicationRecord
  has_many :university_offers
  has_many :offers, through: :university_offers

  validates :name, :level, :kind, :shift, presence: true
end
