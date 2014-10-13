class DeleteTagsFromBlogs < ActiveRecord::Migration
  def change
    remove_column(:blogs, :tags, :string)
  end


end
