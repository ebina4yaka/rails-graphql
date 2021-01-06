class RenameUserIdColumnToUser < ActiveRecord::Migration[6.1]
  def change
    rename_column :users, :user_id, :screen_name
  end
end
