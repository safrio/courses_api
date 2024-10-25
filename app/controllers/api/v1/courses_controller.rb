# frozen_string_literal: true

class Api::V1::CoursesController < Api::ApiController
  include Api

  def index
    courses = Course.includes(:author, :competences).all

    render json: courses
  end

  def show
    render json: course
  end

  def create
    render json: Course.create!(course_params), status: :created
  end

  def update
    course.update!(course_params)

    render json: course
  end

  def destroy
    render json: course.destroy!
  end

  private

  def course
    @course ||= Course.find(params[:id])
  end

  def course_params
    params.permit(:name, :author_id, course_competences_attributes: [:competence_id])
  end
end
