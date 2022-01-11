class UsersController < ApplicationController
  before_action :set_user, only: [:bookmarks, :show, :edit, :update, :followings, :followers ]

  def index
    @users = User.all
    @post_images = PostImage.where(user_id: [current_user.id, *current_user.following_ids])
    @post_image = PostImage.new
  end

  def show
    @post_images = @user.post_images
    @post_image = PostImage.new
  end

  def edit
    unless  @user == current_user
      redirect_to session[:previous_url] = request.referer
    end
  end

  def update
    if @user.update(user_params)
      redirect_to session[:previous_url], notice:'successfully'
    else
    flash.now[:alert] = 'unsuccessfully'
    render :edit
    end
  end

  def followings
    @users = @user.followings
    render 'follows'
  end

  def followers
    @users = @user.followers
    render 'followers'
  end

  def bookmarks
    bookmarks = Bookmark.where(user_id: @user.id).pluck(:post_image_id)
    @post_images = PostImage.find(bookmarks)
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

end
