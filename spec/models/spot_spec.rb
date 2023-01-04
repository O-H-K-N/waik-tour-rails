require 'rails_helper'

RSpec.describe Spot, type: :model do
  describe 'バリデーションテスト' do
    let(:country) { FactoryBot.create(:country) }

    it "地点名、地点英語名、緯度、軽度がある場合、有効である" do
      spot = FactoryBot.build(:spot, country_id: country.id)
      expect(spot).to be_valid
    end

    context "地点名がない場合" do
      let(:spot) { FactoryBot.build(:spot, country_id: country.id, name: nil) }
      subject { spot.valid? }

      it "無効である" do
        subject
        expect(spot).to_not be_valid
      end

      it "エラー文が表示される" do
        subject
        expect(spot.errors[:name]).to include("を入力してください")
      end
    end

    context "地点英語名がない場合" do
      let(:spot) { FactoryBot.build(:spot, country_id: country.id, name_ens: nil) }
      subject { spot.valid? }

      it "無効である" do
        subject
        expect(spot).to_not be_valid
      end

      it "エラー文が表示される" do
        subject
        expect(spot.errors[:name_ens]).to include("を入力してください")
      end
    end

    context "緯度がない場合" do
      let(:spot) { FactoryBot.build(:spot, country_id: country.id, lat: nil) }
      subject { spot.valid? }

      it "無効である" do
        subject
        expect(spot).to_not be_valid
      end

      it "エラー文が表示される" do
        subject
        expect(spot.errors[:lat]).to include("を入力してください")
      end
    end

    context "緯度がない場合" do
      let(:spot) { FactoryBot.build(:spot, country_id: country.id, lng: nil) }
      subject { spot.valid? }

      it "無効である" do
        subject
        expect(spot).to_not be_valid
      end

      it "エラー文が表示される" do
        subject
        expect(spot.errors[:lng]).to include("を入力してください")
      end
    end

    describe 'アソシエーションテスト' do
      it 'countryモデルとの関係がN:1となっている' do
        # Spot.reflect_on_association(:country).macroで関係性を取得
        expect(Spot.reflect_on_association(:country).macro).to eq :belongs_to
      end
    end
  end
end
