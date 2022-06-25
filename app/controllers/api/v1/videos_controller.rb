class Api::V1::VideosController < ApiController
  include YoutubeApi

  # 一覧で表示する動画を取得
  def many_video
    # スポットに関する動画を取得
    @search_results = Video.where(spot: params[:spot_name])
    @response = []

    if saved_and_recent?
      @search_results.each do |result|
        @response << { video_id: result.video_id, title: result.title, thumbnail: result.thumbnail, view_count: result.view_count, published_at: result.published_at.strftime("%Y/%m/%d") }
      end
    elsif saved_and_old?
      begin
        # Youtube APIから動画一覧を取得
        get_videos(params, params[:iso])
        # 取得した動画一覧をDBに更新保存
        update_videos(@api_responses, @search_results)
        # 取得した動画一覧をレスポンスで返す
        set_videos
      rescue
        @response = { error: ResourceNotFound }
      end
    else
      begin
        # Youtube APIから動画一覧を取得
        get_videos(params, params[:iso])
        # 取得した動画をDBに保存
        save_videos(@api_responses, params)
        # 取得した動画一覧をレスポンスで返す
        set_videos
      rescue
        @response = { error: ResourceNotFound }
      end
    end

    render json: @response.sort{|x, y| x[:view_count]  <=> y[:view_count] }.reverse
  end

  private

  # 地点に関する動画を全て取得
  def set_videos
    @search_results = Video.where(spot: params[:spot_name])
    # 取得した動画一覧をレスポンスで返す
    @search_results.each do |result|
      @response << { video_id: result.video_id, title: result.title, thumbnail: result.thumbnail, view_count: result.view_count, published_at: result.published_at.strftime("%Y/%m/%d") }
    end
  end

  # 地点に関する動画をDBから取得できる & 動画が最近更新されている
  def saved_and_recent?
    @search_results.present? && @search_results.first.recently?
  end

  # 地点に関する動画をDBから取得できる & 動画が最近更新されていない
  def saved_and_old?
    @search_results.present? && !@search_results.first.recently?
  end
end