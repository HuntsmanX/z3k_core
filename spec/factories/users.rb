require 'faker'

FactoryGirl.define do
  factory :user, class: User do |f|
    f.email                  { Faker::Internet.email }
    f.password               { '123456789QwErTy'}
    f.password_confirmation  { '123456789QwErTy'}
  end
end
