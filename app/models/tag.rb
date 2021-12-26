class Tag < ApplicationRecord
  has_many :tag_maps, dependent: :destroy
  #throughオプションでtagsと関連付け
  has_many :post_images, through: :tag_maps

end
