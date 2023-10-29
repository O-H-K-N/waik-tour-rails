class Admin::BaseController < ApplicationController
  before_action :check_admin
  #layoutはadmin独自のものを用意し定義させる。
  layout 'admin/layouts/application'

  private

  def not_authenticated
    flash[:warning] = 'ログインしてください'
    redirect_to admin_login_path
  end

  # 管理者チェック
  def check_admin
    if current_user.general?
      logout
      flash[:danger] = t('defaults.admin_login')
      redirect_to admin_login_path
    end
  end
end
