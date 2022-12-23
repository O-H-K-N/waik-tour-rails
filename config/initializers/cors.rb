Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
<<<<<<< HEAD
    origins '*'
=======
    origins 'vtourhub.jp'
>>>>>>> 304ff98 (Add：本番用管理者ユーザを作成)

    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head]
  end
end
