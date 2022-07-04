class Admin::NewsListsController < Admin::BaseController
  before_action :set_news_list, only: %i{edit update destroy}

  #一覧は検索機能とページネーションを実装
  def index
    @q = NewsList.ransack(params[:q])
    @news_lists = @q.result(distinct: true).order(created_at: :desc).page(params[:page]).per(30)
  end

  def new
    @news_list = NewsList.new
  end

  def create
    @news_list = NewsList.new(news_list_params)
    if @news_list.save
      redirect_to admin_news_lists_path, success: t('.success', id: @news_list.id)
    else
      render :new
    end
  end

  def edit; end

  def update
    if @news_list.update(news_list_params)
      redirect_to admin_news_lists_path, success: t('.success', id: @news_list.id)
    else
      flash.now[:danger] = t('.danger')
      render :edit
    end
  end

  def destroy
    @news_list.destroy!
    redirect_to admin_news_lists_path, success: t('.success', id: @news_list.id)
  end

  private

  def set_news_list
    @news_list = NewsList.find(params[:id])
  end

  def news_list_params
    params.require(:news_list).permit(
      :content
    )
  end
end
