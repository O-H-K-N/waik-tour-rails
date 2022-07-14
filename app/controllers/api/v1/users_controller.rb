class Api::V1::UsersController < ApiController
  before_action :authenticate!, only: %i[me]

  def show
    user = User.find(params[:id])
    render json: user
  end

  def create
    user = User.new(user_params)

    if user.save
      render json: { user: user }
    else
      render json: { status: '400' }
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