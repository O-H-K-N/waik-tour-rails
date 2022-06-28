class Spot < ApplicationRecord
  belongs_to :country
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
