# == Schema Information
#
# Table name: users
#
#  id               :bigint           not null, primary key
#  crypted_password :string
#  email            :string           not null
#  name             :string           not null
#  role             :integer          default("general"), not null
#  salt             :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
class User < ApplicationRecord
  has_many :requests, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  # ユーザがブックマーク登録しているスポットをすべて取得
  has_many :bookmark_spots, through: :bookmarks, source: :spot
  # JWT読み込み
  include JwtToken
  authenticates_with_sorcery!

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :name, presence: true
  validates :name, length: { in: 2..20 }, allow_blank: true
  validates :email, presence: true
  validates :email, uniqueness: true, format: { with: VALID_EMAIL_REGEX }, allow_blank: true
  validates :password, presence: true, on: :create
  validates :password, length: { minimum: 8 }, if: -> { new_record? || changes[:crypted_password] }, allow_blank: true
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  #0を一般ユーザ、1を管理ユーザとする
  enum role: { general: 0, admin: 1 }

  #spotがブックマークに登録されているかを確認
  def bookmark?(spot)
    bookmark_spots.include?(spot)
  end

  #spotをブックマークに追加
  def bookmark(spot)
    bookmark_spots << spot
  end

  # 対象のspotをブックマークから削除
  def unbookmark(spot)
    bookmark_spots.destroy(spot)
  end
end
