class Imagefile < ApplicationRecord

    extend FriendlyId

    mount_uploader :image, ImageUploader

    friendly_id :name, use: :scoped, scope: :site_id

    belongs_to :site
    belongs_to :item

    public

    def self.update_details(site, list)
        if !list.blank?
            list.each do |image, name|
                obj = site.imagefiles.find_by_slug(image)
                obj.name = name
                obj.save
            end
        end
    end

    def self.new_image(item, newupload)
        if !newupload.blank?
            image = Imagefile.new
            image.image = newupload
            image.site = item.site
            image.item = item
            image.name = item.name
            image.save
            item.check_default_image
        end
    end

    private

end
