# Admin::BaseControllerを継承させる。
class Admin::UserSessionsController < Admin::BaseController
	# 自動ログインをスキップ
  skip_before_action :require_login, only: %i[new create]
  skip_before_action :check_admin, only: %i[new create]
	# ログイン画面は基底クラスのlayoutとは違うので、新たなlayoutを定義しておく
  layout 'admin/layouts/admin_login'

  def new
    if logged_in?
      redirect_to admin_root_path
    end
  end

  def create
    @user = login(params[:email], params[:password])
    if @user
      redirect_to admin_root_path, success: t('.success')
    else
      flash[:danger] = t('.danger')
      render :new
    end
  end

  def destroy
    logout
    flash[:success] = t('.success')
    redirect_to admin_login_path
  end
end
