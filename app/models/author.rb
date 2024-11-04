# frozen_string_literal: true

class Author < ApplicationRecord
  has_many :courses

  validates :name, presence: true
end
