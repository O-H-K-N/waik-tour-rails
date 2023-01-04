FactoryBot.define do
  factory :request do
    area { 'アメリカ' }
    spot { 'ロサンゼルス' }
    user
  end
end