class Image < ApplicationRecord
  # config.autoload_paths += Dir[Rails.root.join('app', 'uploaders')]
  mount_uploader :image, ImageUploader
  belongs_to :product
end
