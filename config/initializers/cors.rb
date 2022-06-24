Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
		# 開発環境では以下の通りでOKだが、本番環境では実際のURLに書き換える
		# localhost:8080：Vue.jsの開発環境
    origins 'localhost:8080'

    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head]
  end
end