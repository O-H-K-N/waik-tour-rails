class Api::V1::SpotsController < ApplicationController
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
end
