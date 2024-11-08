class CourseController < ApplicationController
  def update_documents
    course_id = params[:course_id]
    render json: { message: "Documents updated for course #{source}" }
  end
end