# frozen_string_literal: true

class RemoveAuthor < ApplicationInteractor
  object :author, class: Author
  validates :new_author, presence: true

  run_in_transaction!

  def execute
    Course.where(author_id: author.id).update!(author: new_author)
    author.delete
  end

  private

  def new_author
    @new_author ||= Author.where.not(id: author.id).sample
  end
end
