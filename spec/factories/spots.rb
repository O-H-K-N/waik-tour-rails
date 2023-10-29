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
FactoryBot.define do
  factory :spot do
    name { 'ロサンゼルス' }
    name_ens { 'Los Angeles' }
    lat { '34.0194' }
    lng { '-118.411' }
    country
  end
end
