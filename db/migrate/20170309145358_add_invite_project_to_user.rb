class AddInviteProjectToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :invite_project, :integer
  end
end
