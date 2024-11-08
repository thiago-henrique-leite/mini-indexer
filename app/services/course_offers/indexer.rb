module CourseOffers
  class Indexer
    INDEX_NAME = 'course_offers'.freeze

    def initialize(client)
      @client = client
    end

    def perform
      build_documents
      index_documents
      delete_documents
    end

    private

    attr_reader :client, :documents

    def offers
      Offer.enabled.includes(:university_offer, :course)
    end

    def build_documents
      @documents = offers.map do |offer|
        CourseOffers::DocumentBuilder.new(offer).build
      end
    end

    def index_documents
      client.instance.index_documents(INDEX_NAME, documents)
    end
  end
end
