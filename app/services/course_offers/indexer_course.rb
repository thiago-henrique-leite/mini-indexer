module CourseOffers
  class Indexer
    INDEX_NAME = 'course_offers'.freeze

    def initialize(client, course_id)
      @client = client
      @course_id = course_id
    end

    def perform
      build_documents
      # pegar as ofertas do indice chamar o client search_documents
      # método para comparar a diferença entre os dois retornar as ofertas novas e que precisam ser desabilitadas
      delete_documents
      indexer_documents
    end

    private

    attr_reader :client, :documents

    def offers
      #check
      Offer.enabled.where(id: course_id).includes(:university_offer, :course)
    end

    def build_documents
      @documents = offers.map do |offer|
        CourseOffers::DocumentBuilder.new(offer).build
      end
    end

    def delete_documents
      client.instance.delete_documents(INDEX_NAME, documents)
    end

    def search_documents
      client.instance.search_documents(INDEX_NAME, documents)
    end
  end
end
