class CreatePostImages < ActiveRecord::Migration[5.2]
  def change
    create_table :post_images do |t|
      t.string :image_id
      t.string :title
      t.text :content
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
