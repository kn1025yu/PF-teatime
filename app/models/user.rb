class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :post_images, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :bookmarked_post_images, through: :bookmarks, source: :post_image
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverse_of_relationships, source: :user

  def follow(other_user)#フォローユーザは自分自身ではないかの検証
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)#すでにフォローしているときの処理
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end

  #ブックマークしているか否かの条件分岐
  def bookmarks_by?(post_images_id)
    bookmarks.where(post_images_id: post_images_id).exists?
  end

  attachment :profile_image
  validates :password, presence: true, on: :create
  validates :name, uniqueness: true,
    length: { minimum: 1, maximum: 25 }
  validates :introduction,
    length: { maximum: 250 }

end
