class AddTargetToProjects < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :target, :text
  end
end
