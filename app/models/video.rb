# == Schema Information
#
# Table name: videos
#
#  id           :bigint           not null, primary key
#  area         :string           not null
#  published_at :datetime         not null
#  spot         :string           not null
#  thumbnail    :string           not null
#  title        :string           not null
#  view_count   :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  video_id     :string           not null
#
class Video < ApplicationRecord
  # 10日以内に更新されたものか確認
  def recently?
    updated_at > Time.current.days_ago(10)
  end
end
