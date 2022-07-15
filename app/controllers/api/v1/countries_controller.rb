class Api::V1::CountriesController < ApiController
  # 地点登録されている国一覧を取得
  def index
    iso = []
    areas = []
    countries = Country.all
    if params[:flag] == 'areas_name'
      # DB内の全ての国名を返す
      countries.each do |country|
        areas << country.name
      end
      render json: {areas: areas }
    else
      # 地点を一つでも含んだ国のみを返す
      countries.each do |country|
        if country.spots.present?
          iso << country.iso.downcase
          areas << country
        end
      end
      render json: {areas: areas, iso: iso }
    end
  end

  # 国コード(iso)で判別し国を取得
  def set_country
    country = Country.find_by(iso: params[:iso])
    spots = Spot.find_by(country_id: country.id)

    # 地点登録されている国をjsonで返す
    if spots.present?
      render json: country
    else
      render json: country, status: :bad_request
    end
  end
end
