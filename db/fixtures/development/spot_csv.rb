require 'csv'

csv = CSV.read('db/fixtures/csv/spots.csv')
i = 1

csv.each do |line|
  id = i
  country_id = line[0]
  name = line[1]
  name_ens = line[2]
  lat = line[3]
  lng = line[4]
  i= i+1

  Spot.seed(:id) do |s|
    s.id = id
    s.country_id = country_id
    s.name = name
    s.name_ens = name_ens
    s.lat = lat
    s.lng = lng
  end
end
