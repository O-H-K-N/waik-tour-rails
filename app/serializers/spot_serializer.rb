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
class SpotSerializer < ActiveModel::Serializer
  attributes :id, :name, :name_ens, :lat, :lng, :click_count
  attributes :area
  has_many :video, serializer: VideoSerializer do
    object.videos.order("RANDOM()").first
  end

  def area
    object.country
  end
end
