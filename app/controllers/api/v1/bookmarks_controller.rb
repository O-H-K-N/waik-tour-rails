class Api::V1::BookmarksController < ApiController
  def index
    render json: spots,
           root: 'spots',
           adapter: :json,
           each_serializer: SpotSerializer,
           current_user: current_user
  end

  # お気に入り登録
  def create
    current_user.bookmark(spot)
  end

  # お気に入り登録解除
  def destroy
    current_user.unbookmark(spot)
  end

  private

  def spots
    @spots ||= current_user.bookmark_spots
  end

  def spot
    @spot ||= Spot.find(params[:id])
  end
end
