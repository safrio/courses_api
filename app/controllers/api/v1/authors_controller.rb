# frozen_string_literal: true

class Api::V1::AuthorsController < Api::ApiController
  include Api

  def index
    authors = Author.all

    render json: authors
  end

  def show
    render json: author
  end

  def create
    render json: Author.create!(author_params), status: :created
  end

  def update
    author.update!(author_params)

    render json: author
  end

  def destroy
    command = RemoveAuthor.run(author:)

    if command.valid?
      render json: { status: :success }
    else
      render json: { error: command.errors.full_messages.first }, status: 500
    end
  end

  private
  def author
    @author ||= Author.find(params[:id])
  end

  def author_params
    params.permit(:name)
  end
end
