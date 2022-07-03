class Request < ApplicationRecord
  belongs_to :user
  validates :area, presence: true
  validates :spot, presence: true
  validates :spot, length: { in: 2..20 }, allow_blank: true

  # 0を未確認、1を確認済とする
  enum check: { uncheck: 0, checked: 1 }
end
