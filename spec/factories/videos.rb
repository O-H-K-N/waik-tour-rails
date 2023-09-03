# == Schema Information
#
# Table name: videos
#
#  id           :bigint           not null, primary key
#  area         :string           not null
#  published_at :datetime         not null
#  spot         :string           not null
#  thumbnail    :string           not null
#  title        :string           not null
#  view_count   :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  video_id     :string           not null
#
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
