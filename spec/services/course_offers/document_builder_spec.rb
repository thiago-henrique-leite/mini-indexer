RSpec.describe CourseOffers::DocumentBuilder do
  describe '#build' do
    let(:offer) { create(:offer) }
    let(:course) { offer.course }
    let(:university_offer) { offer.university_offer }

    subject { described_class.new(offer).build }

    it 'builds the document' do
      expect(subject).to eq(
        object_id: offer.id,
        course_name: course.name,
        level: course.level,
        kind: course.kind,
        shift: course.shift,
        full_price: university_offer.full_price,
        max_payments: university_offer.max_payments,
        enrollment_semester: university_offer.enrollment_semester,
        discount_percentage: offer.discount_percentage
      )
    end
  end
end
