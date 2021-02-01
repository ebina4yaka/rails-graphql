class AddImageUrlToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :image_url, :string, null: false, default: ''
  end
end
