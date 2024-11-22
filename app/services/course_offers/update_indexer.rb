module CourseOffers
  class UpdateIndexer
    INDEX_NAME = 'course_offers'.freeze

    def initialize(client)
      @client = client
    end

  def perform(course_id)
    offers = search_offers_by_course(course_id)
    update_index(offers)
  end

  def update_index(offers)
    offer_ids = offers.pluck(:id)

    indexed_offers = search_indexed_offers(offer_ids)

    offers_to_index = offers.reject { |offer| indexed_offers.include?(offer.id) }
    offers_to_delete = offers.select { |offer| !indexed_offers.include?(offer.id) }

    delete_documents(offers_to_delete)

    build_documents(offers_to_index)
    index_documents

    { removed_count: offers_to_delete.size, created_count: offers_to_index.size }
  end

  private

  attr_reader :client

  def search_offers_by_course(course_id)
    Offer.enabled.where(course_id: course_id).includes(:university_offer, :course)
  end

  def search_indexed_offers(offer_ids)
    index_documents = client.instance.search_documents(INDEX_NAME, { query: { terms: { offer_id: offer_ids } } })
    index_documents.map { |doc| doc['id'] } # id das ofertas q ja estao indexadas?
  end

  def delete_documents(offers_to_delete)
    offer_ids = offers_to_delete.map(&:id)

    client.instance.delete_documents(INDEX_NAME, {query: { terms: { offer_id: offer_ids } }})
  end

  def build_documents(offers)
    documents = offers.map do |offer|
      CourseOffers::DocumentBuilder.new(offer).build
    end
  end
  def index_documents
    client.instance.index_documents(INDEX_NAME, documents)
  end
end
