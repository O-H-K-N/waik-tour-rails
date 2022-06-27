class ApiController < ActionController::API
  # 認証処置をまとめたモジュールを読み込み
  include Api::UserAuthenticator
end
