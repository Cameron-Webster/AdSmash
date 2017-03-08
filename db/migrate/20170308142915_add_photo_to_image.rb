class AddPhotoToImage < ActiveRecord::Migration[5.0]
  def change
    add_column :images, :photo, :string
  end
end
