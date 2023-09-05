class CountrySerializer < ActiveModel::Serializer
  attributes :id, :name, :name_ens, :iso
  attributes :spots

  def spots
    object.spots
  end
end
