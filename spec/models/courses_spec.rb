RSpec.describe Course do
  describe 'associations' do
    it { is_expected.to have_many(:university_offers) }
    it { is_expected.to have_many(:offers).through(:university_offers) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:kind) }
    it { is_expected.to validate_presence_of(:level) }
    it { is_expected.to validate_presence_of(:shift) }
  end
end
