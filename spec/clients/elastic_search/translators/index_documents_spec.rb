RSpec.describe ElasticSearch::Translators::IndexDocuments do
  describe '#translate' do
    let(:index) { 'test_index' }
    let(:documents) do
      [
        {
          object_id: 1,
          name: 'Engenharia de Software',
          level: 'Ensino Infantil',
          kind: 'Semi EaD',
          shift: 'Virtual',
          full_price: 899.99,
          max_payments: 60,
          enrollment_semester: '2026.2',
          discount_percentage: 49.90
        }
      ]
    end

    subject { described_class.new(index, documents).translate }

    it 'translates documents' do
      is_expected.to eq([
        {
          index: {
            _index: 'test_index',
            _id: 1,
          },
        },
        {
          object_id: 1,
          name: 'Engenharia de Software',
          level: 'Ensino Infantil',
          kind: 'Semi EaD',
          shift: 'Virtual',
          full_price: 899.99,
          max_payments: 60,
          enrollment_semester: '2026.2',
          discount_percentage: 49.90
        }
      ])
    end
  end
end
