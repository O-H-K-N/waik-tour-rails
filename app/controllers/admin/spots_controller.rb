class Admin::SpotsController < Admin::BaseController
  before_action :set_spot, only: %i{show edit update destroy}

  #一覧は検索機能とページネーションを実装
  def index
    @q = Spot.ransack(params[:q])
    @spots = @q.result(distinct: true).includes(:country).order(created_at: :asc).page(params[:page]).per(30)
  end

  def show
    @videos = Video.where(spot: @spot.name)
  end

  def new
    @spot = Spot.new
  end

  def create
    @spot = Spot.new(spot_params)
    if @spot.save
      flash.now[:success] = t('.success', id: @spot.id, name: @spot.name)
      redirect_to admin_spot_path(@spot), success: t('.success', id: @spot.id, name: @spot.name)
    else
      render :new
    end
  end

  def edit; end

  def update
    if @spot.update(spot_params)
      redirect_to admin_spot_path(@spot), success: t('.success', id: @spot.id, name: @spot.name)
    else
      flash.now[:danger] = t('.danger')
      render :edit
    end
  end

  def destroy
    @videos = Video.where(spot: @spot.name)
    # スポットに関する動画を全て削除
    if @videos.present?
      @videos.each do |video|
        video.destroy!
      end
    end
    @spot.destroy!
    redirect_to admin_spots_path, success: t('.success', id: @spot.id, name: @spot.name)
  end

  private

  def set_spot
    @spot = Spot.find(params[:id])
  end

  def spot_params
    params.require(:spot).permit(
      :country_id,
      :name,
      :name_ens,
      :lat,
      :lng,
      :click_count
    )
  end
end
