# == Schema Information
#
# Table name: news_lists
#
#  id          :bigint           not null, primary key
#  content     :text             not null
#  content_ens :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
FactoryBot.define do
  factory :news_list do
    content { Faker::Lorem.sentence(word_count: 10) }
    content_ens { Faker::Lorem.characters(number: 100) }
  end
end
