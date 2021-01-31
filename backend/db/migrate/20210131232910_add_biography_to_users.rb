class AddBiographyToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :biography, :string, null: false, default: ''
  end
end
