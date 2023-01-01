FactoryBot.define do
  factory :video do
    area { 'アメリカ' }
    spot { 'ロサンゼルス' }
    video_id { 'nZZalM5GbUE' }
    title { 'Most Dangerous Neighborhood in Los Angeles? : Walking Compton' }
    thumbnail { 'https://i.ytimg.com/vi/nZZalM5GbUE/mqdefault.jpg' }
    published_at { DateTime.now }
    view_count { 129669 }
  end
end