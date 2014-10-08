class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :text
      t.string :name
      t.string :email
      t.integer :vote
      t.integer :blog_id

      t.timestamps
    end
  end
end
