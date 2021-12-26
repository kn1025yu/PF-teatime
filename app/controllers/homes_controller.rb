class HomesController < ApplicationController

  def top
    @post_images = PostImage.all.order(created_at: :desc)
  end

end
