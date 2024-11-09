class IndexerController < ApplicationController

  def update_by_course_id
    course_ids = params[:id]
    teste = indexer.update_by_course_id(course_ids)
    
    render json: { :message => teste }
  end
  
  private
  
  def create_entity
    indexer = CourseOffers::Indexer.new(Elasticsearch::Client)
  end
end