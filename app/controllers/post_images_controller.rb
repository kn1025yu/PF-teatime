class PostImagesController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def new
    @post_image = PostImage.new
  end

  def create
    @post_image = PostImage.new(post_image_params.reject{ |key, _| key == 'tag_name'})
    @post_image.user_id = current_user.id
    tag_list = params[:post_image][:tag_name].split(nil)
    if @post_image.save
      @post_image.save_tag(tag_list)
      redirect_to post_images_path
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def index
    @post_image = PostImage.new
    #フォローしているユーザーと自分の投稿
    @post_images = PostImage.where(user_id: [current_user.id, *current_user.following_ids])
  end

  def show
    @post_image = PostImage.find(params[:id])
    @user = @post_image.user
    @post_comment = PostComment.new
  end

  def edit
    if @post_image.user == current_user
      render :edit
    else
      redirect_to post_images_path
    end
  end

  def update
    if @post_image.update(post_image_params.reject{ |key, _| key == 'tag_name'})
      tag_list = params[:post_image][:tag_name].split(nil)
      @post_image.save_tag(tag_list)
    redirect_to post_image_path(@post_image), notice:'successfully'
    else
    @post_images = PostImage.all
    flash.now[:alert] = 'unsuccessfully'
    render :edit
    end
  end

  def destroy
    @post_image.destroy
    redirect_to post_images_path
  end

  def search
    @tag_list = Tag.all #投稿一覧表示ページで全てのタグを表示するために、タグを全取得
    @tag = Tag.find(params[:tag_id]) #クリックしたタグを取得
    @post_images = @tag.post_images.all #クリックしたタグに紐付けられた投稿を全て表示
  end

  private

  def post_image_params
    params.require(:post_image).permit(:image, :content, :title, :tag_name)
  end

  def ensure_correct_user
    @post_image = PostImage.find(params[:id])
  end

end
