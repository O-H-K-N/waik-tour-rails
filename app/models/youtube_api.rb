module YoutubeApi
  require 'google/apis/youtube_v3'

  # Youtube
  def get_videos(query, region, after: 2.years.ago, before: Time.now)
    youtube = Google::Apis::YoutubeV3::YouTubeService.new
    youtube.key = Rails.application.credentials.google[:youtube_api_key]
    @api_responses = []

    # 検索結果を取得
    search_results = youtube.list_searches(
      :snippet,
      type: "video",
      q: query[:spot_name_ens] + " " +"walking tour 4k",
      max_results: 24,
      region_code: region,
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

    # 各動画の再生回数を取得（list_searchesメソッドでは再生回数を取得できないため）
    search_results.items.each_with_index do |item, index|
      video_id = search_results.items[index].id.video_id
      video_results = youtube.list_videos(
        :statistics,
        id: video_id,
        max_results: 24,
        fields: 'items(statistics(view_count))'
      )

      view_count = video_results.items[0].statistics.view_count
      snippet = item.snippet
      thumbnail = snippet.thumbnails.medium.url
      # { video_id・動画タイトル・サムネ・再生回数 } を返す
      @api_responses << { video_id: video_id, title: snippet.title, thumbnail: thumbnail, view_count: view_count, published_at: snippet.published_at }
      @api_responses
    end
  end

  # Youtube動画を保存
  def save_videos(results, query)
    results.each do |result|
      Video.create!(
        area: query[:area_name],
        spot: query[:spot_name],
        video_id: result[:video_id],
        title: result[:title],
        thumbnail: result[:thumbnail],
        view_count: result[:view_count],
        published_at: result[:published_at]
      )
    end
  end

  # DBにあるYoutube動画を更新保存
  def update_videos(latest_results, past_results)
    past_results.each_with_index do |result, index|
      result.update!(
        video_id: latest_results[index][:video_id],
        title: latest_results[index][:title],
        thumbnail: latest_results[index][:thumbnail],
        view_count: latest_results[index][:view_count],
        updated_at: Time.current
      )
    end
  end
end