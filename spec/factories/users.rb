# == Schema Information
#
# Table name: users
#
#  id               :bigint           not null, primary key
#  crypted_password :string
#  email            :string           not null
#  name             :string           not null
#  role             :integer          default("general"), not null
#  salt             :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
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
