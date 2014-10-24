class ChangeDefaultForCommentVotes < ActiveRecord::Migration
  def change
    change_column :comments, :vote, :integer, default: 0
  end
end
