# frozen_string_literal: true

class Course < ApplicationRecord
  belongs_to :author
  has_many :course_competences, dependent: :destroy
  has_many :competences, through: :course_competences
  accepts_nested_attributes_for :course_competences

  validates :name, :author, presence: true
  validates :name, uniqueness: { scope: :author }
end
