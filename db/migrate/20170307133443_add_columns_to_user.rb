class AddColumnsToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :name, :string
    add_column :users, :last_name, :string
    add_column :users, :company, :string
    add_column :users, :job_title, :string
    add_column :users, :avatar, :string
    add_column :users, :bio, :text
  end
end
