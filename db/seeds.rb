# frozen_string_literal: true

require 'faker'

3.times do
  Category.create(name: Faker::Job.unique.title)
end
