class Datafile < ApplicationRecord

    extend FriendlyId

    mount_uploader :data, RawdataUploader

    friendly_id :name, use: :scoped, scope: :site_id

    belongs_to :site
    belongs_to :item

    public

    def self.update_details(site, list)
        if !list.blank?
            list.each do |dfile, name|
                obj = site.datafiles.find_by_slug(dfile)
                obj.name = name
                obj.save
            end
        end
    end


    def self.new_datafile(item, newdatafile)
        if !newdatafile.blank?
            df = Datafile.new
            df.data = newdatafile
            df.site = item.site
            df.item = item
            df.name = item.name
            df.save
            fm = FileMagic.new
            df.filetype = fm.file(df.data.file.file)
            df.save
        end
    end

    private

end
