class Api::V1::RequestsController < ApiController
  def create
    request = current_user.requests.new(request_params)

    if request.save
      render json: request
    else
      render json: request.errors, status: :bad_request
    end
  end

  private

  def request_params
    params.require(:request).permit(
      :area,
      :spot,
      :check
    )
  end
end
