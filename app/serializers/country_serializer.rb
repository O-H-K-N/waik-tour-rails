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
class CountrySerializer < ActiveModel::Serializer
  attributes :id, :name, :name_ens, :iso
  attributes :spots

  def spots
    object.spots
  end
end
