class Api::V1::UserSessionsController < ApiController
  def create
    user = User.authenticate(params[:email], params[:password])

    if user
      token = user.create_tokens
      render json: { token: token }
    else
      render json: { status: '401' }
    end
  end
end