class RemoveCampaignStartFromProjects < ActiveRecord::Migration[5.0]
  def change
    remove_column :projects, :campaign_start, :date
  end
end
