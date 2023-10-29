# == Schema Information
#
# Table name: videos
#
#  id           :bigint           not null, primary key
#  published_at :datetime         not null
#  thumbnail    :string           not null
#  title        :string           not null
#  view_count   :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  spot_id      :bigint           not null
#  video_id     :string           not null
#
# Indexes
#
#  index_videos_on_spot_id  (spot_id)
#
# Foreign Keys
#
#  fk_rails_...  (spot_id => spots.id)
#
FactoryBot.define do
  factory :video do
    video_id { 'nZZalM5GbUE' }
    title { 'Most Dangerous Neighborhood in Los Angeles? : Walking Compton' }
    thumbnail { 'https://i.ytimg.com/vi/nZZalM5GbUE/mqdefault.jpg' }
    published_at { DateTime.now }
    view_count { 129669 }
    spot
  end
end
