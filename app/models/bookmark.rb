class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :spot
	#user_idとspot_idの組み合わせがuniqueであることを設定
  validates :user_id, uniqueness: { scope: :spot_id}
end
