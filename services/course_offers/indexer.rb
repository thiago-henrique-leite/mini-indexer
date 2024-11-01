module CourseOffers
  class Indexer
    COURSE_OFFERS_INDEX = 'course_offers'.freeze

    def initialize
      client = Clients::ElasticSearch::Client.new
      translator = Clients::ElasticSearch::Translator.new
    end

    def perform
      documents = translator.translate(build_documents, COURSE_OFFERS_INDEX)
      client.index(documents)
    end

    private

    def build_documents
      offers.map do |offer|
        DocumentBuilder.new(offer).build_document
      end
    end

    def offers
      Offer.enabled.includes(:course, :university_offer)
    end
  end
end
