require 'csv'

csv = CSV.read('db/fixtures/csv/countries.csv')
i = 1

csv.each do |line|
  id = i
  name = line[0]
  name_ens = line[1]
  iso = line[2]
  i= i+1

  Country.seed(:id) do |s|
    s.id = id
    s.name = name
    s.name_ens = name_ens
    s.iso = iso
  end
end
