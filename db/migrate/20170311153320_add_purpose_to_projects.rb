class AddPurposeToProjects < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :purpose, :text
  end
end
