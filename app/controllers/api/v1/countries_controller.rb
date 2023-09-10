class Api::V1::CountriesController < ApiController
  before_action :find_country, only: %i[show]

  def index
    countries = if type == 'all'
                  Country.includes(:spots)
                else
                  Country.joins(:spots).distinct
                end
    render json: countries,
           root: 'areas',
           adapter: :json,
           each_serializer: CountrySerializer
  end

  def show
    render json: @country,
           root: 'area',
           adapter: :json,
           each_serializer: CountrySerializer
  end

  private

  def find_country
    @country = Country.find(params[:id])
  end

  def type
    params[:type]
  end
end
