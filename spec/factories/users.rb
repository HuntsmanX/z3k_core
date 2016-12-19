require 'faker'

FactoryGirl.define do
  City.find_or_create_by(name: 'Kharkiv', locale: 'RU', timezone: 'Europe/Kiev')
  City.find_or_create_by(name: 'Coimbatore', locale: 'EN', timezone: 'Asia/Kolkata')

  factory :user_ua, class: User do |f|
    f.email                  { Faker::Internet.email }
    f.city_id                { City.find_by_name('Kharkiv').id }
    f.password               { '123456789QwErTy'}
    f.password_confirmation  { '123456789QwErTy'}
    f.names(                 {
                                first_name:     Faker::StarWars.specie,
                                last_name:      Faker::StarWars.vehicle,
                                first_name_eng: Faker::StarWars.specie,
                                last_name_eng:  Faker::StarWars.vehicle
                              })

  end

  factory :user_in, class: User do |f|
    f.email                  { Faker::Internet.email }
    f.city_id                { City.find_by_name('Coimbatore').id }
    f.password               { '123456789QwErTy'}
    f.password_confirmation  { '123456789QwErTy'}
    f.names(                 {
                                 first_name:     Faker::StarWars.specie,
                                 last_name:      Faker::StarWars.vehicle,
                                 first_name_eng: Faker::StarWars.specie,
                                 last_name_eng:  Faker::StarWars.vehicle
                             })
  end
end
