FactoryBot.define do
  factory :news_list do
    content { Faker::Lorem.sentence(word_count: 10) }
    content_ens { Faker::Lorem.characters(number: 100) }
  end
end