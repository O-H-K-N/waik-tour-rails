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
require 'rails_helper'

RSpec.describe Video, type: :model do
  describe 'バリデーションテスト' do
    let(:spot) { FactoryBot.create(:spot) }
    let(:video) { FactoryBot.create(:video, spot: spot) }

    it "国、地点名、動画ID、タイトル、サムネイル、公開日、閲覧数がある場合、有効である" do
      video = FactoryBot.build(:video)
      expect(video).to be_valid
    end
  end
end
