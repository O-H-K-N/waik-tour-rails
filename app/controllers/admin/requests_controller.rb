class Admin::RequestsController < Admin::BaseController
  before_action :set_request, only: %i{show edit update}

  #一覧は検索機能とページネーションを実装
  def index
    @q = Request.ransack(params[:q])
    @requests = @q.result(distinct: true).includes(:user).order(created_at: :desc).page(params[:page]).per(15)
  end

  def show; end

  def edit; end

  def update
    @request.update!(check: "checked")
    redirect_to admin_requests_path, success: t('.success', id: @request.id)
  end

  private

  def set_request
    @request = Request.find(params[:id])
  end

end
