FactoryBot.define do
  factory :spot do
    name { 'ロサンゼルス' }
    name_ens { 'Los Angeles' }
    lat { '34.0194' }
    lng { '-118.411' }
    country
  end
end