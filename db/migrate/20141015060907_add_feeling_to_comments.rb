class AddFeelingToComments < ActiveRecord::Migration
  def change
    add_column :comments, :feeling, :string, default: "Hasta la vista, baby"
  end
end
