class AddRequirementToProjects < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :requirement, :text
  end
end
