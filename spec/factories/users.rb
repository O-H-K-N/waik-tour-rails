FactoryBot.define do
  factory :user do
    trait :general do
      name                  {Faker::Name.name}
      email                 {Faker::Internet.free_email}
      password              {Faker::Internet.password(min_length: 8)}
      password_confirmation { password }
      role                  { 'general' }
    end

    trait :admin do
      name                  { Faker::Name.name }
      email                 { Faker::Internet.free_email }
      password              { Faker::Internet.password(min_length: 8) }
      password_confirmation { password }
      role                  { 'admin' }
    end
  end
end