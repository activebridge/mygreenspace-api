class CreateSpaces < ActiveRecord::Migration
  def change
    create_table :spaces do |t|
      t.timestamps                null: false

      t.integer :width
      t.integer :length

      t.belongs_to :user
    end
  end
end
