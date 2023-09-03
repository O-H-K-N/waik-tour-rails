# == Schema Information
#
# Table name: spots
#
#  id          :bigint           not null, primary key
#  click_count :integer          default(0)
#  lat         :decimal(11, 8)   not null
#  lng         :decimal(11, 8)   not null
#  name        :string           not null
#  name_ens    :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  country_id  :bigint
#
# Indexes
#
#  index_spots_on_country_id  (country_id)
#
# Foreign Keys
#
#  fk_rails_...  (country_id => countries.id)
#
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
