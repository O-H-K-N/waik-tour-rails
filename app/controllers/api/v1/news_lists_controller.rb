class Api::V1::NewsListsController < ApiController
  def index
    news_lists = NewsList.all.reverse
    render json: news_lists,
           root: 'news_lists',
           adapter: :json,
           each_serializer: NewsListSerializer
  end
end
