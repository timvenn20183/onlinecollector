class Imagefile < ApplicationRecord

    mount_uploader :image, ImageUploader

    belongs_to :site
    belongs_to :item

end
