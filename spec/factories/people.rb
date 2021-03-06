# Read about factories at https://github.com/thoughtbot/factory_girl
require 'faker'

FactoryGirl.define do
  factory :person do
    first_name {Faker::Name.first_name}
    password {Faker::Internet.password(8)}
    password_confirmation { |u| u.password }
    email {Faker::Internet.email}
    gender "M"
  end

  factory :confirmed_person, :parent => :person do
    after(:create) { |person| person.confirm! }
  end
end
