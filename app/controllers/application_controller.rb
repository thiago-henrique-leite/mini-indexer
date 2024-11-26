class ApplicationController < ActionController::API

	def index
		indexer_entity.perform
		render json: { message: "Indexação realizada com sucesso." }
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
		CourseOffers::Indexer.new(ElasticSearch::Client.instance)
	end
end
