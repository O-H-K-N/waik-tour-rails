class Api::V1::SpotsController < ApiController
  # 国に紐づくスポット一覧を返す
  def index
    if params[:flag] == 'all_spot'
      # Spotテーブルのすべての地点とその国、動画を返す
      all_spots = Spot.all.order(click_count: :desc)
      spots = []
      areas = []
      videos = []
      all_spots.each do |spot|
        # videoを保有している地点のみ有効
        if Video.where(spot: spot.name) != []
          spots << spot
          areas << spot.country
          ramdam_data = Video.where(spot: spot.name).order("RANDOM()").first
          videos << { video_id: ramdam_data.video_id, title: ramdam_data.title, thumbnail: ramdam_data.thumbnail, view_count: ramdam_data.view_count.to_s(:delimited), published_at: ramdam_data.published_at.strftime("%Y/%m/%d") }
        end
      end
      render json: { spots: spots, areas: areas, videos: videos }
    else
      # 取得した国IDが有する地点情報を返す
      country = Country.find(params[:country_id])
      spots = country.spots
      if spots.present?
        render json: { area: country, spots: spots }
      else
        render json: country, status: :bad_request
      end
    end
  end

  # 地点のカウント数(click_count)を+1する
  def edit
    spot = Spot.find_by(country_id: params[:country_id], id: params[:id])
    spot.update(click_count: spot.click_count + 1)
    render json: { status: 'ok' }
  end
end
