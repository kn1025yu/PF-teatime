class Bookmark < ApplicationRecord

  belongs_to :user
  belongs_to :post_image

  #ブックマークは一つの投稿につき一人一つまで
  validates_uniqueness_of :post_image, scope: :user_id

end
