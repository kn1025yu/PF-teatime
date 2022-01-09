class BookmarksController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  before_action post_image_params, only: [:create, :destroy]

  def create
    bookmark = @post_image.bookmarks.new(user_id: current_user.id)
    bookmark.save
  end

  def destroy
    bookmark = Bookmark.find_by(user_id: current_user.id, post_image_id: @post_image.id)
    bookmark.destroy
  end

  private
  def post_image_params
    @post_image = PostImage.find(params[:post_image_id])
  end
end
