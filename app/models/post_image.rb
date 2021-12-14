class PostImage < ApplicationRecord
  
  belongs_to :user
  attachment :image
  has_many :post_comments, dependent: :destroy
  has_many :tag_maps, dependent: :destroy
  #throughオプションでtagsと関連付け
  has_many :tags, through: :tag_maps
  has_many :bookmarks, dependent: :destroy

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
  
  #postに紐づいているtagの名前を配列として取得
  def save_tag(sent_tags)
    current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
    old_tags = current_tags - sent_tags #送信されたタグから今回の投稿で使った以外のタグをold_tag
    new_tags = sent_tags - current_tags #送信されたタグから新しく作ったタグ
　
　  #古いタグの削除
    old_tags.each do |old|
      self.post_tags.delete PostTag.find_by(tag_name: old)
    end
　
　  #新しいタグの保存
    new_tags.each do |new|
      new_post_tag = PostTag.find_or_create_by(tag_name: new)
      self.post_tags << new_post_tag
    end
  end
  
end
