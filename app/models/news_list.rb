class NewsList < ApplicationRecord
  validates :content, presence: true
  validates :content_ens, presence: true
  validates :content, length: { in: 5..45 }, allow_blank: true
  validates :content_ens, length: { in: 5..70 }, allow_blank: true
end
