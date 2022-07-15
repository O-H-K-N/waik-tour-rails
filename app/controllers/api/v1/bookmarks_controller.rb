class Api::V1::BookmarksController < ApiController
  # お気に入り登録した地点とその国、動画を返す
  def index
    spots = []
    areas = []
    videos = []

    current_user.bookmark_spots.each do |spot|
      # videoを保有している地点のみ有効
      if Video.where(spot: spot.name) != []
        spots << spot
        areas << spot.country
        ramdam_data = Video.where(spot: spot.name).order("RANDOM()").first
        videos << { video_id: ramdam_data.video_id, title: ramdam_data.title, thumbnail: ramdam_data.thumbnail, view_count: ramdam_data.view_count.to_s(:delimited), published_at: ramdam_data.published_at.strftime("%Y/%m/%d") }
      end
    end
    render json: { spots: spots, areas: areas, videos: videos }
  end

  # お気に入り登録
  def create
    spot = Spot.find(params[:spot_id])
    current_user.bookmark(spot)
    render json: { status: 'ok' }
  end

  # お気に入り登録解除
  def destroy
    spot = Spot.find(params[:id])
    current_user.unbookmark(spot)
    render json: { status: 'ok' }
  end

  # お気に入り登録されているかを確認
  def show
    spot = Spot.find(params[:spot_id])
    if current_user.bookmark?(spot) == true
      render json: { status: 'yes' }
    else
      render json: { status: 'no' }
    end
  end
end
