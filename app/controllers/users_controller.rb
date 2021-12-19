class UsersController < ApplicationController

  before_action :set_user, only: [:bookmarks]

  def index
    @users = User.all
    @post_images = PostImage.where(user_id: [current_user.id, *current_user.following_ids])
    @post_image = PostImage.new
  end

  def show
    @user = User.find(params[:id])
    @post_images = @user.post_images
    @post_image = PostImage.new
  end

  def edit
    @user = User.find(params[:id])
    unless  @user == current_user
      redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
    redirect_to :back, notice:'successfully'
    else
    flash.now[:alert] = 'unsuccessfully'
    render :edit
    end
  end

  def followings
    @user = User.find(params[:id])
    @users = @user.followings
    render 'follow_user'
  end

  def followers
    @user = User.find(params[:id])
    @users = @user.followers
    render 'follower_user'
  end

  def bookmarks
    bookmarks = Bookmark.where(user_id: @user.id).pluck(:post_image_id)
    @bookmark_post_images = PostImage.find(bookmarks)
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

end
