class Api::V1::VideosController < ApiController
  include Api::Video

  def index
    unless videos.first&.recently_updated?
      fetch_videos
    end

    render json: videos,
           root: 'videos',
           adapter: :json,
           each_serializer: VideoSerializer,
           meta: {
             area: spot.country,
             spot: spot
           }
  end
end
