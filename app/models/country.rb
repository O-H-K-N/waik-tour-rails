# == Schema Information
#
# Table name: countries
#
#  id         :bigint           not null, primary key
#  iso        :string           not null
#  name       :string           not null
#  name_ens   :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Country < ApplicationRecord
  has_many :spots, dependent: :destroy
  validates :name, presence: true
  validates :name, uniqueness: true
  validates :name_ens, presence: true
  validates :name_ens, uniqueness: true
  validates :iso, presence: true
  validates :iso, uniqueness: true
end
