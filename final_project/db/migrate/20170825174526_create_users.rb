class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :user_name
      t.string :full_name
      t.string :email
      t.integer :age
      t.string :gender
      t.integer :children
      t.string :sexual_preference
      t.string :password

      t.timestamps
    end
  end
end
