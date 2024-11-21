class CourseOffersController < ApplicationController
  def index_courses
    CourseOffers::Indexer.new(ElasticSearch::Client).perform
    render json: { message: 'Indexing course offers'  }, status: :ok
  end
  def update_index_courses
    CourseOffers::IndexUpdate.new(ElasticSearch::Client, params[:course_offer_id]).perform
    render json: { message: 'Update index courses offers' }, status: :ok
  end
end