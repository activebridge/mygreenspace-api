class AddEmailAndPictureToUsers < ActiveRecord::Migration
  def change
    add_column :users, :email, :string
    add_column :users, :picture, :string
  end
end
