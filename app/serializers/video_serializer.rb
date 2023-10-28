# == Schema Information
#
# Table name: videos
#
#  id           :bigint           not null, primary key
#  published_at :datetime         not null
#  thumbnail    :string           not null
#  title        :string           not null
#  view_count   :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  spot_id      :bigint           not null
#  video_id     :string           not null
#
# Indexes
#
#  index_videos_on_spot_id  (spot_id)
#
# Foreign Keys
#
#  fk_rails_...  (spot_id => spots.id)
#
class VideoSerializer < ActiveModel::Serializer
  attributes :id,
             :video_id,
             :title,
             :thumbnail,
             :view_count,
             :published_at,
             :spot_id

  def published_at
    object.published_at.strftime("%Y/%m/%d")
  end
end
