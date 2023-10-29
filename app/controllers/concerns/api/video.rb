module Api::Video
  extend ActiveSupport::Concern
  require 'google/apis/youtube_v3'

  def initialize
    @youtube = Google::Apis::YoutubeV3::YouTubeService.new
    @youtube.key = Rails.application.credentials.google[:youtube_api_key]
  end

  #
  # DBへの保存・更新処理を行う
  #
  def fetch_videos
    videos.present? ? update_videos : save_videos
  end

  #
  # Youtube APIで動画を検索し取得
  #
  def fetch_youtube_videos(after: 2.years.ago, before: Time.now)
    @fetch_youtube_videos ||= @youtube.list_searches(
                                :snippet,
                                type: "video",
                                q: spot.name_ens + " " +"walking tour 4k",
                                max_results: 24,
                                region_code: spot.iso,
                                # HD 動画のみ
                                video_definition: "high",
                                # 20 分を超える動画のみ
                                video_duration: "long",
                                # 埋め込み可能な動画のみを検索
                                video_embeddable: true,
                                # 関連度が高い順
                                order: "relevance",
                                # ２年前より後のみ
                                published_after: after.iso8601,
                                # 本日より前のみ
                                published_before: before.iso8601,
                                fields: 'items(id(videoId), snippet(title, publishedAt,thumbnails(medium(url))))'
                              )
  end

  #
  # Youtube動画の再生回数を取得
  # - list_searchesメソッドでは再生回数を取得できないためlist_videosを使って取得
  #
  def view_count(item)
    @view_count ||= @youtube.list_videos(
                      :statistics,
                      id: item.id.video_id,
                      fields: 'items(statistics(view_count))'
                    ).items[0].statistics.view_count
  end

  #
  # Youtube動画情報を収集
  #
  def youtube_videos
    @youtube_videos ||= fetch_youtube_videos.items.map do |item|
      {
        video_id: item.id.video_id,
        title: item.snippet.title,
        thumbnail: item.snippet.thumbnails.medium.url,
        view_count: view_count(item),
        published_at: item.snippet.published_at
      }
    end
  end

  #
  # 動画情報を保存
  #
  def save_videos
    youtube_videos.each do |result|
      spot.videos.create!(
        video_id: result[:video_id],
        title: result[:title],
        thumbnail: result[:thumbnail],
        view_count: result[:view_count],
        published_at: result[:published_at]
      )
    end
  end

  #
  # 動画情報を更新
  #
  def update_videos
    videos.each_with_index do |result, index|
      result.update!(
        video_id: youtube_videos[index][:video_id],
        title: youtube_videos[index][:title],
        thumbnail: youtube_videos[index][:thumbnail],
        view_count: youtube_videos[index][:view_count],
        updated_at: Time.current
      )
    end
  end

  def videos
    @videos ||= spot.videos
  end

  def spot
    @spot ||= Spot.find(params[:spot_id])
  end
end
