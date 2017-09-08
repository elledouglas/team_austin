class AddInstagramTokenToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :instagram_token, :string
  end
end
