class Country < ApplicationRecord
  has_many :spots, dependent: :destroy
  validates :name, presence: true
  validates :name, uniqueness: true
  validates :name_ens, presence: true
  validates :name_ens, uniqueness: true
  validates :iso, presence: true
  validates :iso, uniqueness: true
end
