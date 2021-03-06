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
  has_many :temp_users, dependent: :destroy

  validates :name, presence: true

  validates :deadline, presence: true
  # validates :status, presence: true - QUESTION: should this be validated? Is there a way?
  validates :brief, presence: false
  # validate :compare_date

  def photos
    return if self.images.empty? && self.images.photo.nil?
    result = []
    self.images.each { |image| result << image.photo unless image.photo.url.nil? }
    return result.flatten
  end
end

# def compare_date
#   return if campaign_start.nil? && deadline.nil?
#   if campaign_start < deadline
#     errors.add(:deadline, "can't be after the campaign_start")
#   end
# end


