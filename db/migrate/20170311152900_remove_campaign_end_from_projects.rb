class RemoveCampaignEndFromProjects < ActiveRecord::Migration[5.0]
  def change
    remove_column :projects, :campaign_end, :date
  end
end
