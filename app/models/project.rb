class Project < ApplicationRecord
  has_many :project_teams
  has_many :users, through: :project_team
  has_many :images
  has_many :comments, through: :images

  validates :name, presence: true
  validates :deadline, presence: true
  validates :status, presence: true
  validates :brief, presence: true

end


