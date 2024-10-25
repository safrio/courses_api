# frozen_string_literal: true

class Api::V1::CompetenciesController < Api::ApiController
  include Api

  def index
    competencies = Competence.all

    render json: competencies
  end

  def show
    render json: competence
  end

  def create
    render json: Competence.create!(competence_params), status: :created
  end

  def update
    competence.update!(competence_params)

    render json: competence
  end

  def destroy
    render json: competence.destroy!
  end

  private

  def competence
    @competence ||= Competence.find(params[:id])
  end

  def competence_params
    params.permit(:name)
  end
end
