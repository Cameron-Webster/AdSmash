class RemoveColumnFromProject < ActiveRecord::Migration[5.0]
  def change
    remove_column :projects, :string, :string
  end
end
