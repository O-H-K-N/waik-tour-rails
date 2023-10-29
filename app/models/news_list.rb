# == Schema Information
#
# Table name: news_lists
#
#  id          :bigint           not null, primary key
#  content     :text             not null
#  content_ens :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class NewsList < ApplicationRecord
  validates :content, presence: true
  validates :content_ens, presence: true
  validates :content, length: { in: 5..60 }, allow_blank: true
  validates :content_ens, length: { in: 5..100 }, allow_blank: true
end
