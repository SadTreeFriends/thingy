class AddPictureToIdeas < ActiveRecord::Migration
  def change
    add_column :ideas, :picture, :string
  end
end
