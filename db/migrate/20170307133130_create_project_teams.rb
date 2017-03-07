class CreateProjectTeams < ActiveRecord::Migration[5.0]
  def change
    create_table :project_teams do |t|
      t.references :user, foreign_key: true
      t.references :project, foreign_key: true

      t.timestamps
    end
  end
end
