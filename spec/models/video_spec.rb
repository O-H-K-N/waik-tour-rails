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
