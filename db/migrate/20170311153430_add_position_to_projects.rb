class AddPositionToProjects < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :position, :text
  end
end
