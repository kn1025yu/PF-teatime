class RanksController < ApplicationController
  def rank
    # 投稿のいいね数ランキング
    @post_image_bookmark_ranks = PostImage.find(Bookmark.group(:post_image_id).order('count(post_image_id) desc').pluck(:post_image_id))
  end
end
