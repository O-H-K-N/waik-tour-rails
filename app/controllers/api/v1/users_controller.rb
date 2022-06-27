class Api::V1::UsersController < ApiController
  before_action :authenticate!, only: %i[me]

  def create
    user = User.new(user_params)

    if user.save
      render json: user
    else
      render json: user.errors, status: :bad_request
    end
  end

  # ログインユーザー情報を返すエンドポイント
  def me
    render json: current_user
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation, :name)
  end
end