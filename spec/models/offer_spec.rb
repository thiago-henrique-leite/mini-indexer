RSpec.describe Offer do
  describe 'associations' do
    it { is_expected.to belong_to(:university_offer) }
    it { is_expected.to have_one(:course).through(:university_offer) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:discount_percentage) }
    it { is_expected.to validate_numericality_of(:discount_percentage).is_greater_than(0).is_less_than_or_equal_to(100) }
  end

  describe 'scopes' do
    describe '.enabled' do
      subject { described_class.enabled }

      context 'when there are enabled offers' do
        let!(:offer) { create(:offer) }

        it { is_expected.to contain_exactly(offer) }
      end

      context 'when there are disabled offers' do
        let!(:offer) { create(:offer, :disabled) }

        it { is_expected.to be_empty }
      end
    end
  end
end
