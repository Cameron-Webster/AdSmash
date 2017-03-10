class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  include PgSearch
  pg_search_scope :global_search, against: [ :name, :last_name, :email ]


  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
        :omniauthable , omniauth_providers: [:linkedin]

  mount_uploader :avatar, PhotoUploader

  validates :name, presence: true
  validates :last_name, presence: true
  validates :company, presence: true



has_many :project_teams, dependent: :destroy
has_many :comments
has_many :projects, through: :project_teams
has_many :notifications, foreign_key: :recipient_id

validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create

  before_save :normalize

  def normalize
    self.name = self.name.downcase
    self.last_name = self.last_name.downcase
  end

  def self.find_for_linkedin_oauth(auth, signed_in_resource=nil)
      user = User.where(email: auth[:info][:email]).first
      if user
        return user
      else
        user = User.create(name:auth[:info][:first_name],
                           last_name:auth[:info][:last_name],
                           email:auth[:info][:email],
                           bio:auth[:info][:description],
                           remote_avatar_url: auth[:info][:image],
                           company: "Undefined",
                           job_title: "Undefined",
                           provider: 'linkedin',
                           password:Devise.friendly_token[0,20])
        return user
      end
  end
#-------------------------
end
