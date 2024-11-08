module CourseOffers
  class Indexer
    INDEX_NAME = 'course_offers'.freeze

    def initialize(client)
      @client = client
    end

    def perform
      build_documents
      index_documents
    end

    private

    attr_reader :client, :documents

    def offers
      Offer.enabled.includes(:university_offer, :course)
    end

    def offers_disabled
      Offer.where(enabled: false).includes(:university_offer, :course)
    end

    def build_documents_enabled
      @documents_offers_enabled = offers.map do |offer|
        CourseOffers::DocumentBuilder.new(offer).build
      end
    end

    def build_documents_disabled
      @documents_offers_disabled = offers_disabled.map do |offer|
        CourseOffers::DocumentBuilder.new(offer).build
      end
    end

    def index_documents
      client.instance.index_documents(INDEX_NAME, documents_offers_enabled)
    end

    def delete_index
      client.instance.delete_index(INDEX_NAME, documents_offers_disabled)
    end
  end
end
