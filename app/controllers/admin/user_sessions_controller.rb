# Admin::BaseControllerを継承させる。
class Admin::UserSessionsController < Admin::BaseController
	# 自動ログインをスキップ
  skip_before_action :require_login, only: %i[new create]
	# ログイン画面は基底クラスのlayoutとは違うので、新たなlayoutを定義しておく
  layout 'admin/layouts/admin_login'

  def new;end

  def create
    @user = login(params[:email], params[:password])
		# @user && @user.role == "admin"でユーザの振り分け
    if @user && @user.role == "admin"
      redirect_to admin_root_path, success: t('.success')
    else
      # @userが存在する場合は一旦空にする
      @user = nil
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
