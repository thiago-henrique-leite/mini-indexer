class CourseController < ApplicationController
  def update_documents
    course_id = params[:course_id]
    teste = indexer_entity.perform(course_id)
    render json: { message: "Documents updated for course #{teste}" }
  end

private

  def indexer_entity
    CourseOffers::UpdateIndexer.new(ElasticSearch::Client.instance)
  end
end