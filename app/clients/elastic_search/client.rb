module ElasticSearch
  class Client
    include Singleton

    def index_documents(index, documents)
      body = ElasticSearch::Translators::Documents.new(index, documents).translate

      connection.bulk(body: body)
    end

    def search_documents(index, body)
      connection.search(index: index, body: body)
    end

    def offer_translator(offer)
      ElasticSearch::Translators::Offer.new(offer)
    end

    private

    def connection
      @connection ||= Elasticsearch::Client.new(host: Settings.elastic_search.host)
    end
  end
end
