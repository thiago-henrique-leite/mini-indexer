module CourseOffers
  class DocumentBuilder
    def initialize(offer)
      @offer = offer
    end

    def build_document
      {
        offer_id: offer.id,
        name: course.name,
        kind: course.kind,
        level: course.level,
        shift: course.shift,
        full_price: university_offer.full_price,
        max_payments: university_offer.max_payments,
        enrollment_semester: university_offer.enrollment_semester,
        discount_percentage: offer.discount_percentage,
      }
    end

    private

    attr_reader :offer
    delegate :course, :university_offer, to: :offer
  end
end
