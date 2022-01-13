class BookmarksController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]

  def create
    @post_image = PostImage.find(params[:post_image_id])
    bookmark = @post_image.bookmarks.new(user_id: current_user.id)
    bookmark.save
  end

  def destroy
    @post_image = PostImage.find(params[:post_image_id])
    bookmark = Bookmark.find_by(user_id: current_user.id, post_image_id: @post_image.id)
    bookmark.destroy
  end

end
