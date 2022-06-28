class Admin::VideosController < Admin::BaseController
  #自動ログインをスキップ
  skip_before_action :require_login
  before_action :set_video, only: %i{show edit update destroy}

	#一覧は検索機能とページネーションを実装
  def index
    @q = Video.ransack(params[:q])
    @videos = @q.result(distinct: true).all.order(created_at: :asc).page(params[:page]).per(30)
  end

  def show;end

  def destroy
    @video.destroy!
    redirect_to admin_videos_path, success: t('.success', id: @video.id, video_id: @video.video_id)
  end

  private

  def set_video
    @video = Video.find(params[:id])
  end

  def video_params
    params.require(:video).permit(
      :video_id,
      :area,
      :spot,
    )
  end
end
