# == Schema Information
#
# Table name: requests
#
#  id         :bigint           not null, primary key
#  area       :string           not null
#  check      :integer          default("uncheck")
#  spot       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#
# Indexes
#
#  index_requests_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Request, type: :model do
  describe 'バリデーションテスト' do
    let(:user) { FactoryBot.create(:user, :general) }

    it "国、地点名、ユーザーIDがある場合、有効である" do
      request = FactoryBot.build(:request, user_id: user.id)
      expect(request).to be_valid
    end

    context "国がない場合" do
      let(:request) { FactoryBot.build(:request, user_id: user.id, area: nil) }
      subject { request.valid? }

      it "無効である" do
        subject
        expect(request).to_not be_valid
      end

      it "エラー文が表示される" do
        subject
        expect(request.errors[:area]).to include("を入力してください")
      end
    end

    context "地点名がない場合" do
      let(:request) { FactoryBot.build(:request, user_id: user.id, spot: nil) }
      subject { request.valid? }

      it "無効である" do
        subject
        expect(request).to_not be_valid
      end

      it "エラー文が表示される" do
        subject
        expect(request.errors[:spot]).to include("を入力してください")
      end
    end

    describe 'アソシエーションテスト' do
      it 'userモデルとの関係がN:1となっている' do
        # Spot.reflect_on_association(:country).macroで関係性を取得
        expect(Request.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
  end
end
