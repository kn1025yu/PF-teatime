class PostImagesController < ApplicationController
  def new
    @post_image = PostImage.new
  end

  def create
    @post_image = PostImage.new(post_image_params)
    @post_image.user_id = current_user.id
    tag_list = params[:post][:tag_name].split(nil)
    if @post_image.save
      @post.save_tag(tag_list)
      redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path)
    end
    redirect_to post_images_path
  end

  def index
    @post_image = PostImage.new
    #フォローしているユーザーと自分の投稿
    @post_images = PostImage.where(user_id: [current_user.id, *current_user.following_ids])
  end

  def show
    @post_image = PostImage.find(params[:id])
    @post_comment = PostComment.new
  end

  def destroy
    @post_image = PostImage.find(params[:id])
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
    params.require(:post_image).permit(:image_id, :content)
  end

end
