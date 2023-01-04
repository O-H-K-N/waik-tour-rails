require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーションテスト' do
    let(:general) { FactoryBot.create(:user, :general) }

    it "名前、メールアドレス、パスワード、パスワード確認がある場合、有効である" do
      video = FactoryBot.build(:video)
      expect(video).to be_valid
    end

    context "名前がない場合" do
      let(:general) { FactoryBot.build(:user, :general, name: nil) }
      subject { general.valid? }

      it "無効である" do
        subject
        expect(general).to_not be_valid
      end

      it "エラー文が表示される" do
        subject
        expect(general.errors[:name]).to include("を入力してください")
      end
    end

    context "メールアドレスがない場合" do
      let(:general) { FactoryBot.build(:user, :general, email: nil) }
      subject { general.valid? }

      it "無効である" do
        subject
        expect(general).to_not be_valid
      end

      it "エラー文が表示される" do
        subject
        expect(general.errors[:email]).to include("を入力してください")
      end
    end

    context "メールアドレスがない場合" do
      let(:general) { FactoryBot.build(:user, :general, email: nil) }
      subject { general.valid? }

      it "無効である" do
        subject
        expect(general).to_not be_valid
      end

      it "エラー文が表示される" do
        subject
        expect(general.errors[:email]).to include("を入力してください")
      end
    end

    context "パスワードがない場合" do
      let(:general) { FactoryBot.build(:user, :general, password: nil) }
      subject { general.valid? }

      it "無効である" do
        subject
        expect(general).to_not be_valid
      end

      it "エラー文が表示される" do
        subject
        expect(general.errors[:password]).to include("を入力してください")
      end
    end

    context "パスワード確認がない場合" do
      let(:general) { FactoryBot.build(:user, :general,  password_confirmation: nil) }
      subject { general.valid? }

      it "無効である" do
        subject
        expect(general).to_not be_valid
      end

      it "エラー文が表示される" do
        subject
        expect(general.errors[:password_confirmation]).to include("を入力してください")
      end
    end

    context "パスワードとパスワード確認が不一致の場合" do
      let(:general) { FactoryBot.build(:user, :general,password: 'password', password_confirmation: 'pass') }
      subject { general.valid? }

      it "無効である" do
        subject
        expect(general).to_not be_valid
      end

      it "エラー文が表示される" do
        subject
        expect(general.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
      end
    end
  end
end
