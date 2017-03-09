class Project < ApplicationRecord

  include PgSearch
  pg_search_scope :global_search, against: [ :name, :brand, :brief ],
  associated_against: {
      users: [ :name, :last_name, :email ]
    }


  STATUSES = ["closed", "live"]
  BRANDS = ["Coca-cola", "Budweiser", "Glenfiddich", "The Glenlivet"]



  has_many :project_teams, dependent: :destroy
  has_many :users, through: :project_teams
  has_many :images, dependent: :destroy

  has_many :comments, through: :images

  validates :name, presence: true
  validates :campaign_start, presence: true
  validates :deadline, presence: true
  # validates :status, presence: true - QUESTION: should this be validated? Is there a way?
  validates :brief, presence: true
  validate :compare_date
end

def compare_date
  return if campaign_start.nil? && deadline.nil?
  if campaign_start < deadline
    errors.add(:deadline, "can't be after the campaign_start")
  end
end


