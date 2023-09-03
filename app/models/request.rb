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
class Request < ApplicationRecord
  belongs_to :user
  validates :area, presence: true
  validates :spot, presence: true
  validates :spot, length: { in: 2..20 }, allow_blank: true

  # 0を未確認、1を確認済とする
  enum check: { uncheck: 0, checked: 1 }
end
