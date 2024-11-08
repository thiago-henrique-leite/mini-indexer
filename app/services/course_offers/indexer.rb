module CourseOffers
  class Indexer
    INDEX_NAME = 'course_offers'.freeze

    def initialize(client)
      @client = client
    end

    def perform
      offers = Offer.enabled.includes(:university_offer, :course)
      build_documents(offers)
      index_documents
    end

    def index_course
      #buscar ofertas no bancdo
      #buscar ofertas no indice
      #comparar ofertas
      #remover as ofertas desabilitadas
      #indexar as ofertas novas
    end

    private

    attr_reader :client, :documents

    def build_documents(offers)
      @documents = offers.map do |offer|
        CourseOffers::DocumentBuilder.new(offer).build
      end
    end

    def index_documents
      client.instance.index_documents(INDEX_NAME, documents)
    end
  end
end
