class NewsList < ApplicationRecord
  validates :content, presence: true
  validates :content_ens, presence: true
  validates :content, length: { in: 5..60 }, allow_blank: true
  validates :content_ens, length: { in: 5..100 }, allow_blank: true
end
