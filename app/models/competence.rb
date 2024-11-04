# frozen_string_literal: true

class Competence < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: true
end
