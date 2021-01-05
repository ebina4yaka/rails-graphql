class AddUserIdToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :user_id, :string, null: false, unique: true, uniqueness: true
  end
end
