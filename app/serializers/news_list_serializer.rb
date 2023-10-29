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
class NewsListSerializer < ActiveModel::Serializer
  attributes :id, :content, :content_ens
  attributes :created_at

  def created_at
    object.created_at.strftime("%Y/%m/%d")
  end
end
