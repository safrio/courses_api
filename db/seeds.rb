# frozen_string_literal: true

TORAL_COMPETENCES_COUNT = 5
TOTAL_AUTHORS_COUNT = 5
AUTHOR_HAS_COURSES_COUNT = 2
COURSE_HAS_COMPETENCES_COUNT = 3

competences = FactoryBot.create_list(:competence, TORAL_COMPETENCES_COUNT)
authors = FactoryBot.create_list(:author, TOTAL_AUTHORS_COUNT)
authors.each do |author|
  AUTHOR_HAS_COURSES_COUNT.times do
    course = FactoryBot.create(:course, author:)
    course.competences << competences.sample(COURSE_HAS_COMPETENCES_COUNT)
  end
end
