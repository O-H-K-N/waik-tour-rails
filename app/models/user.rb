class User < ApplicationRecord
  has_many :requests, dependent: :destroy
  # JWT読み込み
  include JwtToken
  authenticates_with_sorcery!

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :name, presence: true
  validates :name, length: { in: 2..20 }, allow_blank: true
  validates :email, presence: true
  validates :email, uniqueness: true, format: { with: VALID_EMAIL_REGEX }, allow_blank: true
  validates :password, presence: true, on: :create
  validates :password, length: { in: 8..20 }, if: -> { new_record? || changes[:crypted_password] }, allow_blank: true
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  #0を一般ユーザ、1を管理ユーザとする
  enum role: { general: 0, admin: 1 }
end
