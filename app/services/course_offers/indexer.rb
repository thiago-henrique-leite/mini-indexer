module CourseOffers
  class Indexer
    INDEX_NAME = 'course_offers'.freeze

    def initialize(client)
      @client = client
    end

    def perform
      offers = search_offers
      build_documents(offers)
      index_documents
    end

    private

    attr_reader :client, :documents
    def search_offers
      Offer.enabled.includes(:university_offer, :course)
    end
    def build_documents(offers)
      @documents = offers.map do |offer|
        CourseOffers::DocumentBuilder.new(offer).build
      end
    end
    def index_documents
      client.instance.index_documents(INDEX_NAME, @documents)
    end
  end
end
