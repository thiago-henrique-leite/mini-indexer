class IndexerController < ApplicationController

  def index
    indexer_entity.perform
    render json: { message: "Indexação realizada com sucesso." }
  end

  def update_by_course_id
    course_ids = params[:id]
    result = indexer_entity.update_by_course_id(course_ids)
    render json: { message: "Atualização realizada com sucesso.", result: result }
  end

  def search_by_course_name
    #para verificar se a query esta certa, eu sei que ta tudo errado fiz feio pq vou apagar
    course_name = params[:course_name]
  
    client = ElasticSearch::Client.instance
  
    body = ElasticSearch::Translators::SearchDocuments.new('course_name', course_name ).translate
  
    result = client.search_documents('course_offers', body)
  
    render json: { message: "Busca realizada com sucesso.", body: body, result: result }
  end
  
  
  private

  def indexer_entity
    # Criando o indexer e passando a instância do cliente Elasticsearch
    CourseOffers::Indexer.new(ElasticSearch::Client.instance)
  end
end
