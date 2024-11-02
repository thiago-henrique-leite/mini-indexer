RSpec.describe CourseOffers::Indexer do
  describe '#perform' do
    let!(:offer) { create(:offer) }
    let(:client_instance) { double(:client_instance, index_documents: nil) }
    let(:client) { double(:client, instance: client_instance) }

    subject { described_class.new(client).perform }

    it 'searches for enabled offers' do
      expect(Offer).to receive(:enabled).and_call_original

      subject
    end

    it 'builds the documents' do
      expect(CourseOffers::DocumentBuilder).to receive(:new).with(offer).and_call_original

      subject
    end

    it 'indexes the documents' do
      expect(client.instance).to receive(:index_documents).with(described_class::INDEX_NAME, an_instance_of(Array))

      subject
    end
  end
end
