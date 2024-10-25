# frozen_string_literal: true

FactoryBot.define do
  factory :competence do
    name { Faker::Educator.subject }
  end
end
