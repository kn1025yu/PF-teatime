class HomesController < ApplicationController

  def top
    @post_image = PostImage.find(params[:id])
    @post_images = PostImage.all.order(created_at: :desc)
    @user = @post_image.user
  end

end
