class CreateProjects < ActiveRecord::Migration[5.0]
  def change
    create_table :projects do |t|
      t.string :name
      t.date :campaign_start
      t.date :campaign_end
      t.text :brief
      t.string :brand
      t.string :status
      t.string :string
      t.date :deadline
      t.string :final_file
      t.string :ad_networks

      t.timestamps
    end
  end
end
