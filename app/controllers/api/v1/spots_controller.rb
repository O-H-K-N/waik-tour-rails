class Api::V1::SpotsController < ApiController
  def index
    render json: spots,
           root: 'spots',
           adapter: :json,
           each_serializer: SpotSerializer
  end

  def edit
    #
    # 地点のカウント数(click_count)を+1する
    #
    spot.increment!(:click_count)
  end

  private

  def spots
    @spots ||= if type == 'recent'
                 Spot.joins(:videos).distinct.recent.order(created_at: :desc)
               else
                 Spot.joins(:videos).distinct.order(created_at: :desc)
               end
  end

  def spot
    @spot ||= Spot.find(params[:id])
  end

  def type
    params[:type]
  end
end
