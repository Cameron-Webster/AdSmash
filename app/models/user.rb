class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

validates :name, presence: true
validates :last_name, presence: true
validates :company, presence: true

has_many :project_teams, dependent: :destroy
has_many :comments
has_many :projects, through: :project_teams

validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create

end
