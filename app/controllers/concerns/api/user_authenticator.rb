module Api::UserAuthenticator
  extend ActiveSupport::Concern

  # リクエストの認証ヘッダーから渡ってくるJWTトークンをもとに 認証されたユーザを返す
  def current_user
    return @current_user if @current_user
    return unless bearer_token

    payload, = User.decode bearer_token
    @current_user ||= User.find_by(id: payload['user_id'])
  rescue JWT::ExpiredSignature
    nil
  end

  # 未ログイン状態のときにunauthorized http statusをクライアントに返す
  def authenticate!
    return if current_user

    head :unauthorized
  end


  def bearer_token
    pattern = /^Bearer /
    header = request.headers['Authorization']

    header.gsub(pattern, '') if header&.match(pattern)
  end
end
