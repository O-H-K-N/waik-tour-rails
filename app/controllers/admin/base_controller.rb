class Admin::BaseController < ApplicationController
  #layoutはadmin独自のものを用意し定義させる。
  layout 'admin/layouts/application'

  private

  def not_authenticated
    flash[:warning] = 'ログインしてください'
    redirect_to admin_login_path
  end
end
