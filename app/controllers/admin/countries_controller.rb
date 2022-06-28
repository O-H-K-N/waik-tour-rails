class Admin::CountriesController < Admin::BaseController
  #自動ログインをスキップ
  skip_before_action :require_login
  before_action :set_country, only: %i{show edit update destroy}

	#一覧は検索機能とページネーションを実装
  def index
    @q = Country.ransack(params[:q])
    @countries = @q.result(distinct: true).all.order(created_at: :asc).page(params[:page]).per(30)
  end

  def show
    @spots = @country.spots.order(id: :asc)
  end

  def new
    @country = Country.new
  end

  def create
    @country = Country.new(country_params)
    if @country.save
      flash.now[:success] = t('.success', id: @country.id, name: @country.name)
      render :show
    else
      render :new
    end
  end

  def edit; end

  def update
    if @country.update(country_params)
      flash.now[:success] = t('.success', id: @country.id, name: @country.name)
      render :show
    else
      flash.now[:danger] = t('.danger')
      render :edit
    end
  end

  def destroy
    @videos = Video.where(area: @country.name)
    # 国に関する動画を全て削除
    if @videos.present?
      @videos.each do |video|
        video.destroy!
      end
    end
    @country.destroy!
    redirect_to admin_countries_path, success: t('.success', id: @country.id, name: @country.name)
  end

  private

  def set_country
    @country = Country.find(params[:id])
  end

  def country_params
    params.require(:country).permit(
      :name,
      :name_ens,
      :iso,
    )
  end
end
