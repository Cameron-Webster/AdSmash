class AddLikesToComment < ActiveRecord::Migration[5.0]
  def change
    add_column :comments, :likes, :integer
  end
end
