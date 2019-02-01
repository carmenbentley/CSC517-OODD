# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :admin do
    email { Faker::Internet.email }
    password {"password"}
    password_confirmation {"password"}
  end

  factory :real_estate_company do
    name { "a company" }
    website { "https://www.acompany.com" }
    address { "Raleigh" }
    size { 500 }
    founded { 1900 }
    revenue { 30000 }
    synopsis { "This is a synopsis."}
  end

  factory :realtor do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    phone_number { "5555555555" }
    email { Faker::Internet.email}
    password { "apassword" }
    password_confirmation { "apassword" }
    real_estate_company { create(:real_estate_company) }
  end

  factory :hunter do
    email { Faker::Internet.email}
    password { "abpassword" }
    password_confirmation { "abpassword" }
  end

  factory :house do |f|
    square_footage { 500 }
    location { "a place" }
    year_built { 1900 }
    style { 'Apartment' }
    list_price { 300000 }
    num_floors { 3 }
    owner { "John Dunn" }
    real_estate_company { create(:real_estate_company) }
    basement { true }
    realtor { create(:realtor) }
  end
end