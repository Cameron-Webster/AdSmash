class Comment < ApplicationRecord
  belongs_to :image
  belongs_to :user
  mount_uploader :attachment, PhotoUploader
end
