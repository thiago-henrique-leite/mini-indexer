class CourseOffersController < ApplicationController
  def index_courses
    CourseOffers::Indexer.new(ElasticSearch::Client, params[:course_offer_id]).perform
    render json: { message: 'Indexing course offers' }, status: :ok
  end
end