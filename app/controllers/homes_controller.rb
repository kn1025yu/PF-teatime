class HomesController < ApplicationController

  def top
    @post_images = PostImage.all.order(created_at: :desc).page(params[:page]).per(5)
  end

end
