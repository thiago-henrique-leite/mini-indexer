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
      offer_ids = offer.pluck(:id)
      
      indexed_offers_ids = client.instance.search_documents(INDEX_NAME, { query: { terms: { offer_id: offer_ids } } })# Retorna o documeto total, não só o offer id
      ## criar um metodo que pegue o offer_id do documento apenas

      offers_to_index = offers.diference(indexed_offers_ids) ##Conferir se esta usando as listas corretas

      client.instance.delete_documents(INDEX_NAME, offer_ids) ## criar metodo que delete os documentos pelo offer_id na classe correta

    # parte 2, buildar e reindexar
      build_documents(offers)
      index_documents

    # retorno
    # count de removidas e criadas
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
