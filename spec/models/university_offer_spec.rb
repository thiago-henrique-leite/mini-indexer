RSpec.describe UniversityOffer do
  describe 'associations' do
    it { is_expected.to belong_to(:course) }
    it { is_expected.to have_many(:offers) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:full_price) }
    it { is_expected.to validate_numericality_of(:full_price).is_greater_than(0) }
    it { is_expected.to validate_presence_of(:max_payments) }
    it { is_expected.to validate_numericality_of(:max_payments).is_greater_than(0) }
    it { is_expected.to validate_presence_of(:enrollment_semester) }
  end
end
