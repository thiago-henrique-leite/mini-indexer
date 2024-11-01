module CourseOffers
  class DocumentBuilder
    def initialize(offer)
      @offer = offer
    end

    def build
      {
        offer_id: offer.id,
        name: course.name,
        level: course.level,
        kind: course.kind,
        shift: course.shift,
        full_price: university_offer.full_price,
        max_payments: university_offer.max_payments,
        enrollment_semester: university_offer.enrollment_semester,
        discount_percentage: offer.discount_percentage
      }
    end

    private

    attr_reader :offer

    delegate :university_offer, :course, to: :offer
  end
end
