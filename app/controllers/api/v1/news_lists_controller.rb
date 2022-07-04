class Api::V1::NewsListsController < ApiController
  def index
    news_lists = NewsList.all
    response = []
    news_lists.each do |news|
      response << { id: news.id, content: news.content, created_at: news.created_at.strftime("%Y/%m/%d") }
    end
    render json: response.reverse
  end
end
