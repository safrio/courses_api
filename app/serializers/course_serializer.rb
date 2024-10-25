# frozen_string_literal: true

class CourseSerializer < ActiveModel::Serializer
  attributes :id, :name, :created_at
  has_many :competences
  belongs_to :author
end
