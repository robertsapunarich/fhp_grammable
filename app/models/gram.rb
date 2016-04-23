class Gram < ActiveRecord::Base
  validates :message, presence: true
  validates :pictures, presence: true
  mount_uploader :picture, PictureUploader
  belongs_to :user
end
