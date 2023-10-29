# == Schema Information
#
# Table name: bookmarks
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  spot_id    :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_bookmarks_on_spot_id              (spot_id)
#  index_bookmarks_on_user_id              (user_id)
#  index_bookmarks_on_user_id_and_spot_id  (user_id,spot_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (spot_id => spots.id)
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :bookmark do
    user
    spot
  end
end
