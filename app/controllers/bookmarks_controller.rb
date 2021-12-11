class BookmarksController < ApplicationController
  def create
    post_image = PostImage.find(params[:post_image_id])
    bookmark = current_user.bookmarks.new(post_image_id: post_image.id)
    bookmark.save
    redirect_to post_image_path(post_image)
  end

  def destroy
    post_image = PostImage.find(params[:post_image_id])
    bookmark = current_user.bookmarks.find_by(post_image_id: post_image.id)
    bookmark.destroy
    redirect_to post_image_path(post_image)
  end
  
end
