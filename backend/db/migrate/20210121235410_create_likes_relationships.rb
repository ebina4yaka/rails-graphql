class CreateLikesRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :likes_relationships do |t|
      t.references :user, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true
      t.timestamps
      t.index [:user_id, :post_id], unique: true
    end
  end
end
