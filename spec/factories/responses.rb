require 'faker'

FactoryGirl.define do
  factory :response, class: Forms::Response do |f|
    f.name { Faker::StarWars.planet }
  end
end
