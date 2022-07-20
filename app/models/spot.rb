class Spot < ApplicationRecord
  belongs_to :country
  has_many :bookmarks, dependent: :destroy
  validates :country_id, presence: true
  validates :name, presence: true
  validates :name, uniqueness: true
  validates :name_ens, presence: true
  validates :name_ens, uniqueness: true
  validates :lat, presence: true
  validates :lat, uniqueness: true
  validates :lng, presence: true
  validates :lng, uniqueness: true


  # 3日以内に作成されたものか確認
  def recently?
    created_at > Time.current.days_ago(3)
  end
end
