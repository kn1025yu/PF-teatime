class SearchsController < ApplicationController
  def search
    @model = params["model"]
    @content = params["content"]
    @method = params["method"]
    @records = search_for(@model, @content, @method)
  end

  def show
    @post_images = PostImage.all
  end

  private
  def search_for(model, content, method)
    if model == 'user'
      if method == 'perfect'
       @user = User.where(name: content)
      elsif method == 'partial'
        User.where('name LIKE ?', "%#{content}%")
      end
    elsif model == 'post_image'
      if method == 'perfect'
        PostImage.where(title: content)
      elsif method == 'partial'
        PostImage.where('title LIKE ?', "%#{content}%")
      end
    end
  end

end
