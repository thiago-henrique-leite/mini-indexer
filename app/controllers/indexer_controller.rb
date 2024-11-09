class IndexerController < ApplicationController

  def update_by_course_id
    indexer = CourseOffers::Indexer.new(Elasticsearch::Client)
    course_ids = params[:id]
    indexer.update_by_course_id(course_ids)

    render json
  end
end