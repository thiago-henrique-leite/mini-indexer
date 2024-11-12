module CourseOffers
  class Indexer
    INDEX_NAME = 'course_offers'.freeze

    def initialize(client)
      @client = client
    end

    def perform
      offers = offers_enabled
      build_documents(offers)
      index_documents
    end

    def update_by_course_id(course_id)
      offers = offers_enabled.by_course_id(course_id)
      list_offer_ids = offers.map(&:id)
      course_name = Course.where(id: course_id).pluck(:name).first
      body = ElasticSearch::Translators::SearchDocuments.new('course_name', course_name).translate
      list_index = client.search_documents(INDEX_NAME, body)
      p   '@@@@@@@@@@@@@@@@@@@'
      p list_index
      list_indexed_offer_ids = extract_ids(list_index)
      index_to_remove = list_indexed_offer_ids.difference(list_indexed_offer_ids)
      result = "
      Ofertas no banco: #{list_offer_ids}
      Body: #{body}
      Ofertas no índice: #{extract_ids(list_indexed_offer_ids)}
      "

      
      # Buscar as ofertas por course 
      # Pegar os offer_ids
      # Ver os que não estão no índice, mas não estão no banco e desabilitar
      # Buildas os documentos e indexar
    end
    
    def extract_ids(response)
      # response.dig('hits', 'hits').map { |hit| hit['_id'].to_i 
      ids = response.map { |item| puts item }
      p '7777777777777777777777'
      response
    end
    private

    attr_reader :client, :documents

    def offers_enabled
      Offer.enabled.includes(:university_offer, :course)
    end

    def build_documents(offers)
      @documents = offers.map do |offer|
        CourseOffers::DocumentBuilder.new(offer).build
      end
    end

    def index_documents
      # Indexando documentos diretamente no Elasticsearch
      client.index_documents(INDEX_NAME, documents)
    end
  end
end
