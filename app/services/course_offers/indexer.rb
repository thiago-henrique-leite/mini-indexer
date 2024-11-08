module CourseOffers
  class Indexer
    INDEX_NAME = 'course_offers'.freeze

    def initialize(client)
      @client = client
    end

    def perform

      offer =  Offer.enabled.includes(:university_offer, :course)
      build_documents(offer)
      index_documents
    end


    def update_index
      offers = Offer.enabled.where(course_id: course_id).includes(:university_offer, :course)
      build_documents(offers)

      offer_ids = offer.pluck(:id)
      indexed_offers_ids = client.instance.search_documents(INDEX_NAME, { query: { terms: { offer_id: offer_ids } } })

      offers_to_index = offers.diference(indexed_offers_ids)
      client.instance.delete_documents(INDEX_NAME, offer_ids)

      index_documents
    end

    private

    attr_reader :client, :documents

    def offers
      Offer.enabled.includes(:university_offer, :course)
    end


    def build_documents(offer)
      @documents = offers.map do |offer|
        CourseOffers::DocumentBuilder.new(offer).build
      end
    end


    def index_documents
      client.instance.index_documents(INDEX_NAME, documents)
    end
  end
end
