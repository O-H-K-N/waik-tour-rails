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

  # Spotテーブルのすべての地点とその国を返す
  def all_spot
    spots = Spot.all.order(click_count: :desc)
    areas = []
    spots.each do |spot|
      areas << spot.country
    end
    render json: { spots: spots, areas: areas }
  end
end
