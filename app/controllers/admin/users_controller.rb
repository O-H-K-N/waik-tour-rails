#管理者に一般ユーザの閲覧、編集、削除の権限を与える。
class Admin::UsersController < Admin::BaseController
  before_action :set_user, only: %i{show edit update destroy}

  # 一覧は検索機能とページネーションを実装
  def index
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true).all.order(created_at: :asc).page(params[:page]).per(20)
  end

  def show; end

  def new
    @user = User.new
  end

  def edit; end

  def create
    @user = User.new(user_params)
    if @user.save
      flash.now[:success] = t('.success', id: @user.id, name: @user.name)
      render :show
    else
      render :new
    end
  end

  def update
    if @user.update(user_params)
      flash.now[:success] = t('.success', id: @user.id, name: @user.name)
      render :show
    else
      flash.now[:danger] = t('.danger')
      render :edit
    end
  end

  def destroy
    @user.destroy!
    redirect_to admin_users_path, success: t('.success', id: @user.id, name: @user.name)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(
      :email,
      :name,
      :password,
      :password_confirmation,
      :role
    )
  end
end