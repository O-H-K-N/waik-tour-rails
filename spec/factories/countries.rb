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
FactoryBot.define do
  factory :country do
    name { 'アメリカ' }
    name_ens { 'United States of America,' }
    iso { 'US' }
  end
end
