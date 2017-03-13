class AddDislikesToComments < ActiveRecord::Migration[5.0]
  def change
    add_column :comments, :dislikes, :integer
  end
end
