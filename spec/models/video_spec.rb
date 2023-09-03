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
require 'rails_helper'

RSpec.describe Video, type: :model do
  describe 'バリデーションテスト' do
    let(:video) { FactoryBot.create(:video) }

    it "国、地点名、動画ID、タイトル、サムネイル、公開日、閲覧数がある場合、有効である" do
      video = FactoryBot.build(:video)
      expect(video).to be_valid
    end
  end
end
