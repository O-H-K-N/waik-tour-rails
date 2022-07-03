class NewsList < ApplicationRecord
  validates :content, presence: true
  validates :content, length: { in: 5..45 }, allow_blank: true
end
