class Image < ApplicationRecord
  belongs_to :project
  has_many :comments, dependent: :destroy
  mount_uploader :photo, PhotoUploader
end
