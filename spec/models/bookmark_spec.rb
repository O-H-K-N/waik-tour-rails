# == Schema Information
#
# Table name: bookmarks
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  spot_id    :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_bookmarks_on_spot_id              (spot_id)
#  index_bookmarks_on_user_id              (user_id)
#  index_bookmarks_on_user_id_and_spot_id  (user_id,spot_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (spot_id => spots.id)
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Bookmark, type: :model do
  describe 'バリデーションのテスト' do
    let(:country) { FactoryBot.create(:country) }
    let(:spot) { FactoryBot.create(:spot, country_id: country.id) }
    let(:user) { FactoryBot.create(:user, :general) }
    let!(:bookmark) { FactoryBot.create(:bookmark, spot_id: spot.id, user_id: user.id) }

    context '既にいいねしている場合' do
      let!(:other_bookmark) { FactoryBot.build(:bookmark, spot_id: spot.id, user_id: user.id) }
      subject { other_bookmark.valid? }

      it 'いいね出来ない' do
        subject
        expect(other_bookmark).to_not be_valid
      end

      it 'エラー文が表示される' do
        subject
        expect(other_bookmark.errors[:user_id]).to include("はすでに存在します")
      end
    end
  end

  describe 'アソシエーションテスト' do
    it 'spotモデルとの関係がN:1となっている' do
      expect(Bookmark.reflect_on_association(:spot).macro).to eq :belongs_to
    end

    it 'userモデルとの関係がN:1となっている' do
      expect(Bookmark.reflect_on_association(:user).macro).to eq :belongs_to
    end
  end
end
