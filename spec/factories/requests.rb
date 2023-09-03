# == Schema Information
#
# Table name: requests
#
#  id         :bigint           not null, primary key
#  area       :string           not null
#  check      :integer          default("uncheck")
#  spot       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#
# Indexes
#
#  index_requests_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :request do
    area { 'アメリカ' }
    spot { 'ロサンゼルス' }
    user
  end
end
