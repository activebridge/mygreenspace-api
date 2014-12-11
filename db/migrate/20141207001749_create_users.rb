class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.timestamps                null: false

      t.string :first_name,       null: false
      t.string :last_name,        null: false
      t.string :email
      t.string :picture
    end
  end
end
