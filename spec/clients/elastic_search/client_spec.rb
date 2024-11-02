RSpec.describe ElasticSearch::Client do
  let(:index) { 'test_index' }
  let(:connection) { instance_double(Elasticsearch::Client) }

  subject(:client) { described_class.instance }

  before { allow(client).to receive(:connection).and_return(connection) }

  describe '#index_documents' do
    let(:documents) { [{ id: 1, title: 'Document 1' }, { id: 2, title: 'Document 2' }] }
    let(:translated_body) { double('translated_body') }
    let(:translator_mock) { instance_double(ElasticSearch::Translators::IndexDocuments, translate: translated_body) }

    before do
      allow(ElasticSearch::Translators::IndexDocuments)
        .to receive(:new)
        .with(index, documents)
        .and_return(translator_mock)
    end

    subject { client.index_documents(index, documents) }

    it 'indexes documents' do
      expect(connection).to receive(:bulk).with(body: translated_body)

      expect { subject }.not_to raise_error
    end
  end

  describe '#search_documents' do
    let(:search_body) { { query: { match: { title: 'Document' } } } }

    subject { client.search_documents(index, search_body) }

    it 'searches documents' do
      expect(connection).to receive(:search).with(index: index, body: search_body)

      expect { subject }.not_to raise_error
    end
  end
end
