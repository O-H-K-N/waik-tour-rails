class Api::V1::SpotsController < ApiController
  # 国に紐づくスポット一覧を返す
  def index
    country = Country.find(params[:country_id])
    spots = country.spots

    if spots.present?
      render json: { area: country, spots: spots }
    else
      render json: country, status: :bad_request
    end
  end

  # 地点のカウント数(click_count)を+1する
  def edit
    spot = Spot.find_by(country_id: params[:country_id], id: params[:id])
    spot.update(click_count: spot.click_count + 1)
    render json: { status: 'ok' }
  end

  # Spotテーブルのすべての地点とその国、動画を返す
  def all_spot
    spots = Spot.all.order(click_count: :desc)
    areas = []
    videos = []
    spots.each do |spot|
      areas << spot.country
      ramdam_data = Video.where(spot: spot.name).order("RANDOM()").first
      videos << { video_id: ramdam_data.video_id, title: ramdam_data.title, thumbnail: ramdam_data.thumbnail, view_count: ramdam_data.view_count.to_s(:delimited), published_at: ramdam_data.published_at.strftime("%Y/%m/%d") }
    end
    render json: { spots: spots, areas: areas, videos: videos }
  end
end
