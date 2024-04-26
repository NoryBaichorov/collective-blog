require 'faker'

3.times do
  Category.create(name: Faker::Job.unique.title)
end