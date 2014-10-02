class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.text :content
      t.string :author
      t.string :tags

      t.timestamps
    end
  end
end
