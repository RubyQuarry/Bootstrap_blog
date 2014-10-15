class AddFeelingToComments < ActiveRecord::Migration
  def change
    add_column :comments, :feeling, :string
  end
end
