require 'rails_helper'

RSpec.describe NewsList, type: :model do
  describe 'バリデーションテスト' do
    it "説明文、英語表記説明文がある場合、有効である" do
      news_list = FactoryBot.build(:news_list)
      expect(news_list).to be_valid
    end

    context "説明文がない場合" do
      let(:news_list) { FactoryBot.build(:news_list, content: nil) }
      subject { news_list.valid? }

      it "無効である" do
        subject
        expect(news_list).to_not be_valid
      end

      it "エラー文が表示される" do
        subject
        expect(news_list.errors[:content]).to include("を入力してください")
      end
    end

    context "英語表記3説明文がない場合" do
      let(:news_list) { FactoryBot.build(:news_list, content_ens: nil) }
      subject { news_list.valid? }

      it "無効である" do
        subject
        expect(news_list).to_not be_valid
      end

      it "エラー文が表示される" do
        subject
        expect(news_list.errors[:content_ens]).to include("を入力してください")
      end
    end
  end
end