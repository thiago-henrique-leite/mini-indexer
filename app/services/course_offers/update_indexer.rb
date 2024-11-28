module CourseOffers
  class UpdateIndexer
    INDEX_NAME = 'course_offers'.freeze

    def initialize(client)
      @client = client
    end

    def perform(course_id)
      offers = search_offers_by_course(course_id)
      update_index(offers, course_id)
    end

    def update_index(offers, course_id)
      indexed_offers = search_indexed_offers(course_id)
      list_offer = offers.pluck(:id)
      @offers_to_index = offers.reject { |offer| indexed_offers.include?(offer.id) }
      offers_to_delete = indexed_offers.select { |offer| !list_offer.include?(offer) }
      delete_documents(offers_to_delete)
      build_documents(offers_to_index)
      index_documents
      { removed_count: offers_to_delete.size, created_count: offers_to_index.size }
    end

    private

    attr_reader :client

    def search_offers_by_course(course_id)
      teste = Offer.enabled.includes(:university_offer, :course).joins(:course).where(courses: { id: course_id })
      puts teste
      teste
    end

    def search_indexed_offers(course_id)
      course_list = []
      course_list << course_id
      index_documents = client.instance.search_documents(INDEX_NAME, { query: { terms: { "course_id": course_list } } })
      index_documents['hits']['hits'].map { |doc| doc['_id'].to_i }
    end

    def delete_documents(offer_ids)
      client.instance.delete_documents(INDEX_NAME, {query: { terms: { offer_id: offer_ids } }})
    end

    def build_documents(offers)
      documents = offers.map do |offer|
        CourseOffers::DocumentBuilder.new(offer).build
      end
    end

    def index_documents
      client.instance.index_documents(INDEX_NAME, @offers_to_index)
    end

  end

end
