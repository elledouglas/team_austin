class AddColumnHeightToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :height, :integer
  end
end
