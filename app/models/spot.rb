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
end
